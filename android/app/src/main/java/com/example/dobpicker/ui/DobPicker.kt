package com.example.dobpicker.ui

import android.app.DatePickerDialog
import android.content.Context
import com.example.dobpicker.utils.DateUtils
import java.util.Calendar
import java.util.Date

class DobPicker {

    fun showDatePicker(
        context: Context,
        title: String,
        selectedDate: Date,
        maxDate: Date,
        onSelectedDate: (String) -> Unit
    ) {
        val selectedCalender = Calendar.getInstance().also {
            it.time = selectedDate
        }

        val datePickerDialog = DatePickerDialog(
            context,
            { _, selectedYear, selectedMonth, selectedDay ->
                val calendar: Calendar = Calendar.getInstance().also {
                    it.set(selectedYear, selectedMonth, selectedDay)
                }
                onSelectedDate(DateUtils.dateFormatter.format(calendar.time))
            },
            selectedCalender.get(Calendar.YEAR),
            selectedCalender.get(Calendar.MONTH),
            selectedCalender.get(Calendar.DAY_OF_MONTH)
        )

        datePickerDialog.datePicker.maxDate = Calendar.getInstance().also {
            it.time = maxDate
        }.timeInMillis
        datePickerDialog.setTitle(title)
        datePickerDialog.setMessage(title)
        datePickerDialog.show()
    }
}
