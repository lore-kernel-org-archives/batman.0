Return-Path: <jtmze87@gmail.com>
MIME-Version: 1.0
Date: Thu, 2 Jul 2009 14:13:16 +0200
Message-ID: <1739bfe0907020513m78e06c83s980ce88b5cb5cca5@mail.gmail.com>
From: jonathan mzengeza <jtmze87@gmail.com>
Content-Type: multipart/alternative; boundary=001636427659ee3f2a046db7f64c
Subject: [B.A.T.M.A.N.] [PATCH] json output from vis server would fail with
	incomplete writes
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

--001636427659ee3f2a046db7f64c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

Jonathan here I am attending a code sprint here at CSIR in South Africa.

We are using B.A.T.M.A.N as a mesh networking software. We ran into a bug
which occurred with web browser whereby the  data written back through the
socket was not complete thereby causing an error with our program.

The fix works by making sure that all the data that is to be sent in the
send_buffer is sent. It checks the value of ret until it equals the size of
the data to be sent.

--

Index: vis.c
===================================================================
--- vis.c    (revision 1336)
+++ vis.c    (working copy)
@@ -580,8 +580,18 @@
             } else {
                 send_buffer = current->json_buffer;
             }
+
+            ret = write( thread_data->socket, send_buffer, strlen(
send_buffer ));

-            ret = write( thread_data->socket, send_buffer, strlen(
send_buffer ) );
+            while(ret != strlen( send_buffer )) {
+                send_buffer += ret;
+
+                if ( fsync(thread_data->socket) != 0 ) {
+                    ret = write(thread_data->socket, send_buffer, strlen(
send_buffer ));
+                }
+
+            }
+
             if( ret != strlen( send_buffer ) || (thread_data->format ==
json) )
             {
                 pthread_mutex_lock( &current->mutex );

--001636427659ee3f2a046db7f64c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi <br><br>Jonathan here I am attending a code sprint here at CSIR in South=
 Africa.<br><br>We are using B.A.T.M.A.N as a mesh networking software. We =
ran into a bug which occurred with web browser whereby the=A0 data written =
back through the socket was not complete thereby causing an error with our =
program.<br>
<br>The fix works by making sure that all the data that is to be sent in th=
e send_buffer is sent. It checks the value of ret until it equals the size =
of the data to be sent.<br><br>--<br><br>Index: vis.c<br>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- vis.c=A0=A0 =A0(revision 1336)<br>+++ vis.c=A0=A0 =A0(working copy)<br>=
@@ -580,8 +580,18 @@<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0} else {<br>=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0send_buffer =3D current-&gt;json_buffe=
r;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0}<br>+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
<br>+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0ret =3D write( thread_data-&gt;socket, s=
end_buffer, strlen( send_buffer ));<br>
=A0<br>-=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0ret =3D write( thread_data-&gt;socket=
, send_buffer, strlen( send_buffer ) );<br>+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0w=
hile(ret !=3D strlen( send_buffer )) {<br>+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0=A0 send_buffer +=3D ret;<br>+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0<br>+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0 if ( fsync(thread_data-&gt;=
socket) !=3D 0 ) {<br>
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0 ret =3D write(thread_dat=
a-&gt;socket, send_buffer, strlen( send_buffer ));<br>+=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0=A0 }<br>+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0<br>+=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0}<br>+=A0=A0 =A0<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0if=
( ret !=3D strlen( send_buffer ) || (thread_data-&gt;format =3D=3D json) )<=
br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0{<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0pthread_mutex_lock( &amp;current-&gt;mutex ); <br><br><br><br>

--001636427659ee3f2a046db7f64c--
