Return-Path: <bradenaran@gmail.com>
MIME-Version: 1.0
Date: Sun, 28 Jul 2013 21:10:33 +0200
Message-ID: <CAKEO+ThzTfEKT_20E-z677iUaxOzsLUV+c9scskBZ2asRSN-8Q@mail.gmail.com>
From: Braden Aran <bradenaran@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Important warnings from alfred 2013.3.0 release
	source
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

I get following important warnings when compiling alfred 2013.3.0

unix_sock.c: In function =91unix_sock_req_data_finish=92:
unix_sock.c:261:7: warning: ignoring return value of =91write=92, declared
with attribute warn_unused_result [-Wunused-result]
  write(client_sock, &status, sizeof(status));
       ^
unix_sock.c: In function =91unix_sock_req_data_reply=92:
unix_sock.c:187:8: warning: ignoring return value of =91write=92, declared
with attribute warn_unused_result [-Wunused-result]
   write(client_sock, buf, sizeof(push->header) + len);
        ^
