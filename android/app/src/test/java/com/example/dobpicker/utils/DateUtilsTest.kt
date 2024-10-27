package com.example.dobpicker.utils

import junit.framework.TestCase.assertEquals
import junit.framework.TestCase.assertNotNull
import org.junit.Test
import java.text.SimpleDateFormat
import org.junit.Assert.*
import java.util.Locale

class DateUtilsTest {

    private val dateFormatter = SimpleDateFormat("yyyy-MM-dd", Locale.US)

    @Test
    fun parseDateCorrectDate() {
        val dateStr = "2023-10-27"
        val expectedDate = dateFormatter.parse(dateStr)
        val result = DateUtils.parseDate(dateStr)
        assertNotNull(result)
        assertEquals(expectedDate, result)
    }

    @Test
    fun parseDateInvalidDateString() {
        val invalidDateStr = "invalid-date"
        val result = DateUtils.parseDate(invalidDateStr)
        assertNull(result)
    }

    @Test
    fun parseDateEmptyDateString() {
        val emptyDateStr = ""
        val result = DateUtils.parseDate(emptyDateStr)
        assertNull(result)
    }
}
