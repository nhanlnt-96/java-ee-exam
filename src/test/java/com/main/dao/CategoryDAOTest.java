package com.main.dao;

import com.main.entity.Category;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

public class CategoryDAOTest {
    private static CategoryDAO categoryDAO;

    @BeforeAll
    public static void setup() {
        categoryDAO = new CategoryDAO();
    }

    @Test
    public void testGetTotalRecord() {
        fail("Not yet implemented");
    }

    @Test
    public void testCreateCategory() {
        Category newCategory = new Category("Action");
        Category insertedCategory = categoryDAO.create(newCategory);

        assertTrue(insertedCategory.getCategoryId() > 0);
    }
}
