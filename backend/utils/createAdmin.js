import dotenv from "dotenv";
import connectDB from "../config/db.js";
import { seedAdminFromEnv } from "./seedAdmin.js";

dotenv.config();

const createAdmin = async () => {
  try {
    await connectDB();
    await seedAdminFromEnv({ throwOnMissing: true });
    process.exit(0);
  } catch (error) {
    console.error(error.message);
    process.exit(1);
  }
};

createAdmin();
