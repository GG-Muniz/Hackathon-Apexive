// odoo_service.js - Mock service for testing
require('dotenv').config();

// Mock Odoo service for testing without real Odoo installation
const mockOdoo = {
  connect: async () => {
    console.log('[MOCK ODOO] Connected to mock Odoo service');
    return true;
  },
  
  create: async (model, data) => {
    const mockId = Math.floor(Math.random() * 10000) + 1000;
    console.log(`[MOCK ODOO] Created ${model} with data:`, data);
    console.log(`[MOCK ODOO] Assigned mock ID: ${mockId}`);
    return mockId;
  },
  
  search: async (model, filters) => {
    console.log(`[MOCK ODOO] Searching ${model} with filters:`, filters);
    return [1001, 1002]; // Mock IDs
  },
  
  read: async (model, ids, fields) => {
    console.log(`[MOCK ODOO] Reading ${model} IDs:`, ids, 'fields:', fields);
    return [{ id: ids[0], name: 'Mock Record' }];
  }
};

module.exports = mockOdoo;