package com.example.ai_workout

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import java.util.Properties
import java.nio.channels.FileChannel;
import io.flutter.plugin.common.MethodChannel;
import java.nio.MappedByteBuffer;
import java.io.FileInputStream;
import org.tensorflow.lite.Interpreter;

class MainActivity: FlutterActivity() {
    val CHANNEL = "ondeviceML";
    private var tflite: Interpreter? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if(call.method == "predictData") {
                try {
                    tflite = Interpreter(loadModelFile("Trikonasana.tflite"));
                } catch (e: Exception) {
                    throw RuntimeException(e)
                }
                
                var args = call.argument<ArrayList<Double>>("arg")
                var prediction = args?.let { predictData(it) }

                if (prediction != null) {
                    if(prediction > 0.0) {
                        result.success(prediction)
                    } else {
                        result.error("UNAVAILABLE", "Pose not available.", null)
                    }
                }
            } 
            else {
                result.notImplemented()
            }
          }
    }
    
    // This method interact with our model and makes prediction returning value of
    fun predictData(input_data: ArrayList<Double>): Float {
        var inputArray = Array(1, {FloatArray(input_data.size)})
        
        var i = 0
        
        for(e in input_data) {
            inputArray[0][i] = e.toFloat()
            i++
        }
        
        var output_data = Array(1, {FloatArray(1)})
        tflite!!.run(inputArray, output_data)
        
        return output_data[0][0]
    }
    
    private fun loadModelFile(modelFilename: String): MappedByteBuffer {
        val assets = getAssets()
        val fileDescriptor = assets.openFd(modelFilename)
        val inputStream = FileInputStream(fileDescriptor.fileDescriptor)
        val fileChannel = inputStream.channel
        val startOffset = fileDescriptor.startOffset
        val declaredLength = fileDescriptor.declaredLength
        return fileChannel.map(FileChannel.MapMode.READ_ONLY, startOffset, declaredLength)
    }

}
