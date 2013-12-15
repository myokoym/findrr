# NEWS

## 0.0.5: 2013-12-15

### Changes

  * Improvements
    * Removed "mtime" column from "Files" table.
      * Bacause it is not necessary to fulltext search.

## 0.0.4: 2013-12-15

### Changes

  * Improvements
    * Added version command.
    * Skip collecting of a path when an error occurred.
    * Use plane-text for history manager.
    * Make update when already having the key.

## 0.0.3: 2013-12-13

### Changes

  * Improvements
    * Use ShortText type to "basename" column.
    * Added "Registers" table.

  * Fixes
    * Skip Errno::ENOENT when collecting filenames.

## 0.0.2: 2013-12-13

Improve the table shcema!

### Changes

  * Improvements
    * Use PatriciaTrie for type of "Files" table.
    * Added "mtime" column to "Files" table.
    * Added "destroy" command as delete the database.

## 0.0.1: 2013-12-09

Initial release!
