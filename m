Message-ID: <BLU122-W8053274D7F88798A76C4AF69C0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_163869a0-b297-40da-8844-d96b784124d6_"
From: Dennis Bartsch <dennis_bartsch@hotmail.com>
Date: Tue, 16 Oct 2007 12:43:59 +0100
In-Reply-To: <200710161204.38008.onelektra@gmx.net>
References: <BLU122-W10D014E29FA86CA3739C9AF6A30@phx.gbl>
	<200710151614.36704.onelektra@gmx.net>
	<6792.85.41.146.90.1192460098.squirrel@krisma.oltrelinux.com> 
	<200710161204.38008.onelektra@gmx.net>
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] development-ipkgs broken
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

--_163869a0-b297-40da-8844-d96b784124d6_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

hey,

installation of the latest development-ipkgs (at least the i386 ones) of 0.=
3-beta fails, because control.tar.gz is missing:

root@NicoAP5G:~# ipkg install http://downloads.open-mesh.net/batman/develop=
ment/i386/batmand_0.3-beta-rv722_i386-gc-elf-32-lsb-dynamic.tgz
Downloading http://downloads.open-mesh.net/batman/development/i386/batmand_=
0.3-beta-rv722_i386-gc-elf-32-lsb-dynamic.tgz
ipkg: /tmp/ipkg-p6lIJa/control.tar.gz: No such file or directory
root@NicoAP5G:~# cd ipkg-p6lIJa/
root@NicoAP5G:~/ipkg-p6lIJa# ls
batmand_0.3-beta-rv722_i386-gc-elf-32-lsb-dynamic.tgz

system is kamikaze 7.06

greets
dennis bartsch

_________________________________________________________________
Freunde treffen. Jetzt den Windows Live=99 Messenger downloaden!
http://get.live.com/messenger/overview=

--_163869a0-b297-40da-8844-d96b784124d6_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'><div style=3D"text-align: left;">hey,<br><br>inst=
allation of the latest development-ipkgs (at least the i386 ones) of 0.3-be=
ta fails, because control.tar.gz is missing:<br><br>root@NicoAP5G:~# ipkg i=
nstall http://downloads.open-mesh.net/batman/development/i386/batmand_0.3-b=
eta-rv722_i386-gc-elf-32-lsb-dynamic.tgz<br>Downloading http://downloads.op=
en-mesh.net/batman/development/i386/batmand_0.3-beta-rv722_i386-gc-elf-32-l=
sb-dynamic.tgz<br>ipkg: /tmp/ipkg-p6lIJa/control.tar.gz: No such file or di=
rectory<br>root@NicoAP5G:~# cd ipkg-p6lIJa/<br>root@NicoAP5G:~/ipkg-p6lIJa#=
 ls<br>batmand_0.3-beta-rv722_i386-gc-elf-32-lsb-dynamic.tgz<br><br>system =
is kamikaze 7.06<br><br>greets<br>dennis bartsch<br></div><br /><hr />Mache=
n Sie Ihre E-Mail-Kontakte zu Messenger-Freunden! <a href=3D'http://redirec=
t.gimas.net/?cat=3Dhmtl&n=3DM1007AI&d=3Dhttp://messenger.live.de/ersteschri=
tte_adressimport.html' target=3D'_new'>Einfacher Adressimport!</a></body>
</html>=

--_163869a0-b297-40da-8844-d96b784124d6_--
