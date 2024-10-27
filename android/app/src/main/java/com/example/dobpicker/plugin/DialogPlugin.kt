package com.example.dobpicker.plugin

import com.example.dobpicker.ui.DobPicker
import com.example.dobpicker.utils.DateUtils
import com.getcapacitor.JSObject
import com.getcapacitor.Plugin
import com.getcapacitor.PluginCall
import com.getcapacitor.PluginMethod
import com.getcapacitor.annotation.CapacitorPlugin

@CapacitorPlugin(name = "DobDialog")
class DialogPlugin : Plugin() {

    @PluginMethod
    fun showDialog(call: PluginCall) {

        val title = call.getString("title") ?: return
        val selectedDate = call.getString("selectedDate")?.let { DateUtils.parseDate(it) } ?: return
        val maxDate = call.getString("maxDate")?.let { DateUtils.parseDate(it) } ?: return

        activity.runOnUiThread {

            DobPicker().showDatePicker(
                context = context,
                title = title,
                selectedDate = selectedDate,
                maxDate = maxDate
            ) { selectedDate ->
                val response = JSObject()
                response.put("selectedDate", selectedDate)
                call.resolve(response)
            }
        }
    }
}
