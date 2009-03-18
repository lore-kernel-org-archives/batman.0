MIME-Version: 1.0
Date: Wed, 18 Mar 2009 15:43:43 +0100
Message-ID: <3ebdcf0a0903180743q3968e6a0wd480347cf70a50ff@mail.gmail.com>
From: Max <rey.web.mail@gmail.com>
Content-Type: multipart/alternative; boundary=0015174c1d90d7d9fb046565b52d
Subject: [B.A.T.M.A.N.] Problem with B.A.T.M.A.N. 0.3.1 rv1206
	(compatibility version 5)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

--0015174c1d90d7d9fb046565b52d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Good afternoon to everybody!

I have to deal with 2 big problems occurred when I run batmand 0.3.1 rv 1206
in meshboxs equipped with OpenWrt Kamikaze 8.09
I detect the following problems:
1) B.A.T.M.A.N. daemon only works whether launched in debug mode. I'm sure
about this because I'm monitoring the network with a packet sniffer.
2) When launched in debug mode (using the command batmand -d 3 ath0 &), the
daemon starts to generate OGMs and to fill up its routing tables in a
correct way. The problem occurs when I tries to ping an host in the network
because the routing process uses the default routing table (that has not
been modified by the batman daemon) and it is not aware on the correct
batman routing tables.

Does someone know how to solve these problems?
Thank you in advance.

Best regards,
Massimo Reineri

--0015174c1d90d7d9fb046565b52d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Good afternoon to everybody!<br><br>I have to deal with 2 big problems occu=
rred when I run batmand 0.3.1 rv 1206 in meshboxs equipped with OpenWrt Kam=
ikaze 8.09<br>I detect the following problems:<br>1) B.A.T.M.A.N. daemon on=
ly works whether launched in debug mode. I&#39;m sure about this because I&=
#39;m monitoring the network with a packet sniffer.<br>
2) When launched in debug mode (using the command batmand -d 3 ath0 &amp;),=
 the daemon starts to generate OGMs and to fill up its routing tables in a =
correct way. The problem occurs when I tries to ping an host in the network=
 because the routing process uses the default routing table (that has not b=
een modified by the batman daemon) and it is not aware on the correct batma=
n routing tables.<br>
<br>Does someone know how to solve these problems?<br>Thank you in advance.=
<br><br>Best regards,<br>Massimo Reineri<br>

--0015174c1d90d7d9fb046565b52d--
