import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseController extends GetxController {
  static SupabaseController instance = Get.find();
  final SupabaseClient supabaseClient = Supabase.instance.client;

  // Function to get a single record by ID
  Future<Map<String, dynamic>?> getOne(
    String table,
    String columnName,
    String value,
  ) async {
    print("GET ONE");
    try {
      final data = await supabaseClient
          .from(table)
          .select()
          .eq(columnName, value)
          .single();
      print("api response GET ONE: $data");
      return data;
    } on PostgrestException catch (error) {
      Get.snackbar(
        'Get Request Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return null;
    } catch (error) {
      Get.snackbar(
        'Get Request Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );

      return null;
    }
  }

  // Function to get a single record by ID
  Future<Map<String, dynamic>?> getOneJoind(
    String table,
    String tableJoined,
    String columnName,
    String value,
  ) async {
    print("GET ONE JOINED");
    try {
      final data = await supabaseClient
          .from(table)
          .select('*, $tableJoined(*)')
          .eq(columnName, value)
          .single();
      return data;
    } on PostgrestException catch (error) {
      Get.snackbar(
        'Get Request Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return null;
    } catch (error) {
      Get.snackbar(
        'Get Request Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );

      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getAllJoined(
    String table,
    String tableJoined, {
    String order_column = "created_at",
  }) async {
    print("GET ONE JOINED");
    try {
      final data = await supabaseClient
          .from(table)
          .select('*, $tableJoined(*)')
          .order(order_column);
      // print("api response GET ALL JOINED: $data");
      return data;
    } on PostgrestException catch (error) {
      Get.snackbar(
        'Get Request Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return null;
    } catch (error) {
      Get.snackbar(
        'Get Request Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );

      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getAllJoinedMine(
    String table,
    String tableJoined, {
    String order_column = "created_at",
    required String findColumn,
    required String findColumnValue,
  }) async {
    print("GET ONE JOINED");
    try {
      final data = await supabaseClient
          .from(table)
          .select('*, $tableJoined(*)')
          .eq(findColumn, findColumnValue)
          .order(order_column);
      // print("api response GET ALL JOINED: $data");
      return data;
    } on PostgrestException catch (error) {
      Get.snackbar(
        'Get Request Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return null;
    } catch (error) {
      Get.snackbar(
        'Get Request Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );

      return null;
    }
  }

  // Function to get all records
  Future<List<Map<String, dynamic>>?> getAll(
    String table, {
    String order_column = "created_at",
  }) async {
    print("GET ALL");
    try {
      final data =
          await supabaseClient.from(table).select("*").order(order_column);
      return data;
    } on PostgrestException catch (error) {
      Get.snackbar(
        'Get all Request Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return null;
    } catch (error) {
      Get.snackbar(
        'Get all Request Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );

      return null;
    }
  }

  // Function to get all records
  Future<List<Map<String, dynamic>>?> getAllMine(
    String table, {
    String order_column = "created_at",
    required String findColumn,
    required String findColumnValue,
  }) async {
    print("GET ALL MINE");
    try {
      final data = await supabaseClient
          .from(table)
          .select("*")
          .eq(findColumn, findColumnValue)
          .order(order_column);
      return data;
    } on PostgrestException catch (error) {
      Get.snackbar(
        'Get all mine Request Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return null;
    } catch (error) {
      Get.snackbar(
        'Get all mine Request Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );

      return null;
    }
  }

  // Function to insert a record
  Future<bool> insert(String table, Map<String, dynamic> body) async {
    try {
      await supabaseClient.from(table).upsert(body);
      return true;
    } on PostgrestException catch (error) {
      Get.snackbar(
        'Insert/Update Request Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return false;
    } catch (error) {
      Get.snackbar(
        'Insert/Update Request Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );

      return false;
    }
  }

  // Function to edit a record
  Future<bool> edit(String table, Map<String, dynamic> body, String reference,
      String referenceValue) async {
    try {
      await supabaseClient
          .from(table)
          .update(body)
          .match({reference: referenceValue});
      return true;
    } on PostgrestException catch (error) {
      Get.snackbar(
        'Update Request Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return false;
    } catch (error) {
      Get.snackbar(
        'Update Request Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );

      return false;
    }
  }

  // Function to delete a record
  Future<bool> delete(
    String table,
    String columnName,
    String value,
  ) async {
    try {
      await supabaseClient.from(table).delete().match({columnName: value});
      return true;
    } on PostgrestException catch (error) {
      Get.snackbar(
        'Delete Request Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return false;
    } catch (error) {
      Get.snackbar(
        'Delete Request Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );

      return false;
    }
  }
}
