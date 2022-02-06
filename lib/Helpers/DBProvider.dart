import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tic_tac_toe/Models/PostListParser.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await initDB();

    return _database!;
  }

  // Create the database and the posts table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'posts_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE posts('
          'userId INTEGER,'
          'id INTEGER PRIMARY KEY,'
          'title TEXT,'
          'body TEXT'
          ')');
    });
  }

  // Insert posts on database
  createPosts(PostListParser postListParser) async {
    await deleteAllPosts();
    final db = await database;
    final res = await db.insert('posts', postListParser.toJson());

    return res;
  }

  addPosts(PostListParser postListParser) async {

    final db = await database;
    final res = await db.insert('posts', postListParser.toJson());

    return res;
  }

  // Delete all posts
  Future<int> deleteAllPosts() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM posts');

    return res;
  }

  Future<int> deletePost(id) async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM posts WHERE id=?', [id]);

    return res;
  }

  Future<List<PostListParser>> getAllPosts() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM posts");

    List<PostListParser> list = res.isNotEmpty
        ? res.map((c) => PostListParser.fromJson(c)).toList()
        : [];

    return list;
  }
}
