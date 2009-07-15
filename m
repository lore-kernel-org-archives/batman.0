Return-Path: <jtmze87@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200907151556.32314.sven.eckelmann@gmx.de>
References: <1739bfe0907150649l61d6b0dga6825e84dc45832d@mail.gmail.com>
	<200907151556.32314.sven.eckelmann@gmx.de>
Date: Wed, 15 Jul 2009 16:26:50 +0200
Message-ID: <1739bfe0907150726l70ee35b1wa92f4fb1aabfdd61@mail.gmail.com>
From: jonathan mzengeza <jtmze87@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [vis] fixed partial json output
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

2009/7/15 Sven Eckelmann <sven.eckelmann@gmx.de>:
>> Partial output was caused by failing to read the HTTP request. This
>> patch reads the HTTP request into a temporary buffer before discarding
>> it.
> This patch creates an endless loop on unrecoverable socket errors. See re=
ad(3)
> for more information about return codes. Please provide more information =
if I
> am wrong.
>
> Best regards,
> =A0 =A0 =A0 =A0Sven

Thanks, is this better?


Signed-off-by: Jonathan Mzengeza <jtmze87@gmail.com>
Index: vis.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- vis.c	(revision 1343)
+++ vis.c	(working copy)
@@ -566,6 +566,7 @@
 	buffer_t *last_send =3D NULL;
 	size_t ret;
 	char* send_buffer =3D NULL;
+  char tmp[512];

 	while ( !is_aborted() ) {

@@ -579,6 +580,11 @@
 				send_buffer =3D current->dot_buffer;
 			} else {
 				send_buffer =3D current->json_buffer;
+				ret =3D read( thread_data->socket, tmp, sizeof( tmp ));
+				while ( ret =3D=3D -1 && errno =3D=3D EAGAIN) {
+				  ret =3D read( thread_data->socket, tmp, sizeof( tmp ));
+				  usleep(250);
+				}
 			}

 			ret =3D write( thread_data->socket, send_buffer, strlen( send_buffer ) =
);
