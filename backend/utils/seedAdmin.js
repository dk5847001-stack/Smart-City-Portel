import User from "../models/User.js";

const requiredAdminKeys = ["ADMIN_NAME", "ADMIN_EMAIL", "ADMIN_MOBILE", "ADMIN_PASSWORD"];

const getAdminEnv = () => {
  const missingKeys = requiredAdminKeys.filter((key) => !process.env[key]?.trim());

  if (missingKeys.length > 0) {
    return {
      adminData: null,
      missingKeys
    };
  }

  return {
    adminData: {
      name: process.env.ADMIN_NAME.trim(),
      email: process.env.ADMIN_EMAIL.trim().toLowerCase(),
      mobile: process.env.ADMIN_MOBILE.trim(),
      password: process.env.ADMIN_PASSWORD.trim(),
      role: "admin",
      department: "",
      isBlocked: false
    },
    missingKeys: []
  };
};

export const seedAdminFromEnv = async ({ throwOnMissing = false } = {}) => {
  const { adminData, missingKeys } = getAdminEnv();

  if (!adminData) {
    const message = `Admin seed skipped. Missing environment variables: ${missingKeys.join(", ")}`;

    if (throwOnMissing) {
      throw new Error(message);
    }

    console.log(message);
    return null;
  }

  const existingAdmin = await User.findOne({ email: adminData.email }).select("+password");

  if (existingAdmin) {
    existingAdmin.name = adminData.name;
    existingAdmin.mobile = adminData.mobile;
    existingAdmin.password = adminData.password;
    existingAdmin.role = "admin";
    existingAdmin.department = "";
    existingAdmin.isBlocked = false;
    await existingAdmin.save();
    console.log(`Admin ready: ${adminData.email}`);
    return existingAdmin;
  }

  const admin = await User.create(adminData);
  console.log(`Admin created: ${adminData.email}`);
  return admin;
};
