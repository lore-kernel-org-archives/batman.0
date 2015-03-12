Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Mar 2015 09:47:22 +0100
Message-ID: <13206880.sTCpC0kvAI@bentobox>
In-Reply-To: <55004A9F.3050908@gmail.com>
References: <55004A9F.3050908@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: "--update-script" flag for
	specifying a command for, running when new data piece is receviced.
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Anatoliy <anatoliy.lapitskiy@gmail.com>
Cc: "'b.a.t.m.a.n@lists.open-mesh.org'" <b.a.t.m.a.n@lists.open-mesh.org>

Applying: alfred: "--update-script" flag for specifying a command for, running 
when new data piece is receviced.
fatal: corrupt patch at line 52
Patch failed at 0001 alfred: "--update-script" flag for specifying a command 
for, running when new data piece is receviced.
The copy of the patch that failed is found in:
   /home/sven/tmp/alfred/.git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

checkpatch.pl --strict ~/test.eml 
WARNING: please, no spaces at the start of a line
#32: FILE: alfred.h:59:
+    int data_type;$

WARNING: please, no spaces at the start of a line
#33: FILE: alfred.h:60:
+    struct list_head list;$

WARNING: please, no spaces at the start of a line
#43: FILE: alfred.h:126:
+    const char *update_script;$

WARNING: please, no spaces at the start of a line
#44: FILE: alfred.h:127:
+    struct list_head changed_data_types;$

WARNING: please, no spaces at the start of a line
#45: FILE: alfred.h:128:
+    int changed_data_type_count;$

ERROR: patch seems to be corrupt (line wrapped?)
#66: FILE: main.c:62:
used for client-server\n");

ERROR: trailing whitespace
#69: FILE: main.c:64:
+    printf("  -c, --update-script                 path to script to $

WARNING: please, no spaces at the start of a line
#69: FILE: main.c:64:
+    printf("  -c, --update-script                 path to script to $

ERROR: code indent should use tabs where possible
#79: FILE: main.c:157:
+        {"update-script",        required_argument,    NULL, 'c'},$

WARNING: please, no spaces at the start of a line
#79: FILE: main.c:157:
+        {"update-script",        required_argument,    NULL, 'c'},$

WARNING: please, no spaces at the start of a line
#88: FILE: main.c:179:
+    globals->update_script = NULL;$

WARNING: please, no spaces at the start of a line
#89: FILE: main.c:180:
+    INIT_LIST_HEAD(&globals->changed_data_types);$

WARNING: please, no spaces at the start of a line
#90: FILE: main.c:181:
+    globals->changed_data_type_count = 0;$

ERROR: trailing whitespace
#96: FILE: main.c:185:
+    while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:dc:", $

WARNING: please, no spaces at the start of a line
#96: FILE: main.c:185:
+    while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:dc:", $

WARNING: suspect code indent for conditional statements (4, 9)
#96: FILE: main.c:185:
+    while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:dc:", 
[...]
          switch (opt) {

CHECK: Alignment should match open parenthesis
#98: FILE: main.c:186:
+    while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:dc:", 
                    &opt_ind)) != -1) {

ERROR: code indent should use tabs where possible
#106: FILE: main.c:245:
+        case 'c':$

WARNING: please, no spaces at the start of a line
#106: FILE: main.c:245:
+        case 'c':$

ERROR: code indent should use tabs where possible
#107: FILE: main.c:246:
+            globals->update_script = optarg;$

WARNING: please, no spaces at the start of a line
#107: FILE: main.c:246:
+            globals->update_script = optarg;$

ERROR: code indent should use tabs where possible
#108: FILE: main.c:247:
+            break;$

WARNING: please, no spaces at the start of a line
#108: FILE: main.c:247:
+            break;$

WARNING: please, no spaces at the start of a line
#140: FILE: recv.c:43:
+    int len, data_len, new_entry;$

ERROR: code indent should use tabs where possible
#149: FILE: recv.c:60:
+        new_entry = 0;$

WARNING: please, no spaces at the start of a line
#149: FILE: recv.c:60:
+        new_entry = 0;$

ERROR: code indent should use tabs where possible
#158: FILE: recv.c:75:
+            new_entry = 1;$

WARNING: please, no spaces at the start of a line
#158: FILE: recv.c:75:
+            new_entry = 1;$

ERROR: code indent should use tabs where possible
#167: FILE: recv.c:83:
+        /* check that data was changed */$

ERROR: trailing whitespace
#168: FILE: recv.c:84:
+        if (new_entry || dataset->data.header.length != data_len || $

ERROR: code indent should use tabs where possible
#168: FILE: recv.c:84:
+        if (new_entry || dataset->data.header.length != data_len || $

WARNING: please, no spaces at the start of a line
#168: FILE: recv.c:84:
+        if (new_entry || dataset->data.header.length != data_len || $

WARNING: suspect code indent for conditional statements (8, 12)
#168: FILE: recv.c:84:
+        if (new_entry || dataset->data.header.length != data_len || 
[...]
+            changed_data_type(globals, data->header.type);

ERROR: code indent should use tabs where possible
#170: FILE: recv.c:85:
+            changed_data_type(globals, data->header.type);$

WARNING: please, no spaces at the start of a line
#170: FILE: recv.c:85:
+            changed_data_type(globals, data->header.type);$

ERROR: code indent should use tabs where possible
#171: FILE: recv.c:86:
+        }$

WARNING: please, no spaces at the start of a line
#171: FILE: recv.c:86:
+        }$

WARNING: please, no spaces at the start of a line
#194: FILE: server.c:144:
+    if (!globals->update_script)$

ERROR: code indent should use tabs where possible
#195: FILE: server.c:145:
+        return;$

WARNING: please, no spaces at the start of a line
#195: FILE: server.c:145:
+        return;$

WARNING: please, no spaces at the start of a line
#197: FILE: server.c:147:
+    struct changed_data_type *data_type = NULL;$

WARNING: please, no spaces at the start of a line
#199: FILE: server.c:149:
+    list_for_each_entry(data_type, &globals->changed_data_types, list) {$

ERROR: code indent should use tabs where possible
#200: FILE: server.c:150:
+        if (data_type->data_type == arg)$

WARNING: please, no spaces at the start of a line
#200: FILE: server.c:150:
+        if (data_type->data_type == arg)$

WARNING: suspect code indent for conditional statements (8, 12)
#200: FILE: server.c:150:
+        if (data_type->data_type == arg)
+            return;

ERROR: code indent should use tabs where possible
#201: FILE: server.c:151:
+            return;$

WARNING: please, no spaces at the start of a line
#201: FILE: server.c:151:
+            return;$

WARNING: please, no spaces at the start of a line
#202: FILE: server.c:152:
+    }$

WARNING: please, no spaces at the start of a line
#204: FILE: server.c:154:
+    data_type = malloc(sizeof(*data_type));$

WARNING: please, no spaces at the start of a line
#205: FILE: server.c:155:
+    data_type->data_type = arg;$

WARNING: please, no spaces at the start of a line
#206: FILE: server.c:156:
+    list_add(&data_type->list, &globals->changed_data_types);$

WARNING: please, no spaces at the start of a line
#207: FILE: server.c:157:
+    globals->changed_data_type_count++;$

ERROR: code indent should use tabs where possible
#217: FILE: server.c:175:
+        changed_data_type(globals, dataset->data.header.type);$

WARNING: please, no spaces at the start of a line
#217: FILE: server.c:175:
+        changed_data_type(globals, dataset->data.header.type);$

ERROR: trailing whitespace
#227: FILE: server.c:370:
+        if (globals->update_script && $

ERROR: code indent should use tabs where possible
#227: FILE: server.c:370:
+        if (globals->update_script && $

WARNING: please, no spaces at the start of a line
#227: FILE: server.c:370:
+        if (globals->update_script && $

WARNING: suspect code indent for conditional statements (8, 12)
#227: FILE: server.c:370:
+        if (globals->update_script && 
[...]
+            /* call update script with list of datatypes_changed */

ERROR: code indent should use tabs where possible
#229: FILE: server.c:371:
+            /* call update script with list of datatypes_changed */$

ERROR: trailing whitespace
#230: FILE: server.c:372:
+            char command[strlen(globals->update_script) + $

ERROR: code indent should use tabs where possible
#230: FILE: server.c:372:
+            char command[strlen(globals->update_script) + $

WARNING: please, no spaces at the start of a line
#230: FILE: server.c:372:
+            char command[strlen(globals->update_script) + $

ERROR: code indent should use tabs where possible
#232: FILE: server.c:373:
+            char buf[7];$

WARNING: please, no spaces at the start of a line
#232: FILE: server.c:373:
+            char buf[7];$

ERROR: code indent should use tabs where possible
#233: FILE: server.c:374:
+            strncpy(command, globals->update_script, sizeof(command));$

WARNING: Missing a blank line after declarations
#233: FILE: server.c:374:
+            char buf[7];
+            strncpy(command, globals->update_script, sizeof(command));

WARNING: please, no spaces at the start of a line
#233: FILE: server.c:374:
+            strncpy(command, globals->update_script, sizeof(command));$

ERROR: code indent should use tabs where possible
#235: FILE: server.c:376:
+            struct changed_data_type *data_type, *is;$

WARNING: please, no spaces at the start of a line
#235: FILE: server.c:376:
+            struct changed_data_type *data_type, *is;$

ERROR: trailing whitespace
#236: FILE: server.c:377:
+            list_for_each_entry_safe(data_type, is, $

ERROR: code indent should use tabs where possible
#236: FILE: server.c:377:
+            list_for_each_entry_safe(data_type, is, $

WARNING: Missing a blank line after declarations
#236: FILE: server.c:377:
+            struct changed_data_type *data_type, *is;
+            list_for_each_entry_safe(data_type, is, 

WARNING: please, no spaces at the start of a line
#236: FILE: server.c:377:
+            list_for_each_entry_safe(data_type, is, $

ERROR: code indent should use tabs where possible
#238: FILE: server.c:378:
+                /* append the datatype to command line */$

CHECK: Alignment should match open parenthesis
#238: FILE: server.c:378:
+            list_for_each_entry_safe(data_type, is, 
+                /* append the datatype to command line */

ERROR: code indent should use tabs where possible
#239: FILE: server.c:379:
+                snprintf(buf, sizeof(buf), " %d", data_type->data_type);$

WARNING: please, no spaces at the start of a line
#239: FILE: server.c:379:
+                snprintf(buf, sizeof(buf), " %d", data_type->data_type);$

ERROR: code indent should use tabs where possible
#240: FILE: server.c:380:
+                strncat(command, buf, sizeof(command) - strlen(command));$

WARNING: please, no spaces at the start of a line
#240: FILE: server.c:380:
+                strncat(command, buf, sizeof(command) - strlen(command));$

ERROR: code indent should use tabs where possible
#242: FILE: server.c:382:
+                /* clean the list */$

ERROR: code indent should use tabs where possible
#243: FILE: server.c:383:
+                list_del(&data_type->list);$

WARNING: please, no spaces at the start of a line
#243: FILE: server.c:383:
+                list_del(&data_type->list);$

ERROR: code indent should use tabs where possible
#244: FILE: server.c:384:
+                free(data_type);$

WARNING: please, no spaces at the start of a line
#244: FILE: server.c:384:
+                free(data_type);$

ERROR: code indent should use tabs where possible
#245: FILE: server.c:385:
+            }$

WARNING: please, no spaces at the start of a line
#245: FILE: server.c:385:
+            }$

ERROR: code indent should use tabs where possible
#247: FILE: server.c:387:
+            printf("executing: %s\n", command);$

WARNING: please, no spaces at the start of a line
#247: FILE: server.c:387:
+            printf("executing: %s\n", command);$

ERROR: code indent should use tabs where possible
#249: FILE: server.c:389:
+            signal(SIGCHLD, SIG_IGN);$

WARNING: please, no spaces at the start of a line
#249: FILE: server.c:389:
+            signal(SIGCHLD, SIG_IGN);$

ERROR: code indent should use tabs where possible
#250: FILE: server.c:390:
+            int pid = fork();$

WARNING: please, no spaces at the start of a line
#250: FILE: server.c:390:
+            int pid = fork();$

ERROR: code indent should use tabs where possible
#251: FILE: server.c:391:
+            if (pid == 0) {$

WARNING: Missing a blank line after declarations
#251: FILE: server.c:391:
+            int pid = fork();
+            if (pid == 0) {

WARNING: please, no spaces at the start of a line
#251: FILE: server.c:391:
+            if (pid == 0) {$

ERROR: code indent should use tabs where possible
#252: FILE: server.c:392:
+                system(command);$

WARNING: please, no spaces at the start of a line
#252: FILE: server.c:392:
+                system(command);$

ERROR: code indent should use tabs where possible
#253: FILE: server.c:393:
+                exit(0);$

WARNING: please, no spaces at the start of a line
#253: FILE: server.c:393:
+                exit(0);$

ERROR: code indent should use tabs where possible
#254: FILE: server.c:394:
+            }$

WARNING: please, no spaces at the start of a line
#254: FILE: server.c:394:
+            }$

ERROR: code indent should use tabs where possible
#255: FILE: server.c:395:
+            globals->changed_data_type_count = 0;$

WARNING: please, no spaces at the start of a line
#255: FILE: server.c:395:
+            globals->changed_data_type_count = 0;$

ERROR: code indent should use tabs where possible
#256: FILE: server.c:396:
+        }$

WARNING: please, no spaces at the start of a line
#256: FILE: server.c:396:
+        }$

total: 44 errors, 59 warnings, 2 checks, 200 lines checked

NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
      scripts/cleanfile

