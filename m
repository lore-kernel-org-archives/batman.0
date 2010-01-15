Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 15 Jan 2010 19:34:38 +0100
References: <20091231033752.GA18781@Sellars>
	<1263185876-24214-1-git-send-email-linus.luessing@web.de>
	<201001151124.25877.lindner_marek@yahoo.de>
In-Reply-To: <201001151124.25877.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3471292.9gXMX0izR9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201001151934.41937.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: atomic variable for vis-srv
	activation
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Linus, Marek Lindner <lindner_marek@yahoo.de>

--nextPart3471292.9gXMX0izR9
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> On Monday 11 January 2010 12:57:56 you wrote:
> > This fixes the bug discovered by Marek Lindner which did not allow
> > turning on the vis-server before an interface has been added. With this
> > patch we are using a global atomic variable for activating and
> > deactiating the vis-server-mode instead, which can be used before
> > inserting an interface.
>=20
> Off-list:
> Wollte mir grad deinen Patch reinziehen, aber trotz "git send-email" ist
>  auch diese Mail is base64 encoded ?? Im Header sehe ich jedenfalls
>  "X-Mailer: git- send-email 1.6.6". Evtl. h=E4ngt das mit charset (utf8)
>  zusammen ?

Aaaalso. Ich habe ersteinmal keine Ahnung woher es kommt. git-format-patch
produziert sowas jedenfalls nicht. git-send-email eigentlich auch nicht (de=
r=20
bleibt immer bei "Content-Type: text/plain; ...". Wenn ich jetzt im Git=20
Quellcode suche, dann finde ich auch nur funktionen um base64 in Mails zu=20
dekodieren.

> @Sven: Hast du eine Idee, woran das liegen k=F6nnte ?

Vielleicht macht der Mailman sowas oder irgendwas anderes auf open-mesh.org=
?=20
Ich habe jetzt einfach mal an meine Adresse auf open-mesh.net die Mail=20
geschickt. Die sieht aber vollkommen in Ordnung aus.

Wenn ich in die mbox von mailman schauen=20
/var/lib/mailman/archives/private/b.a.t.m.a.n.mbox/b.a.t.m.a.n.mbox , dann=
=20
sieht die Mail so aus wie ich sie von git-send-email erwarten wuerde. Kann =
es=20
also sein, dass es beim wieder raussenden passiert? Also nicht das raussend=
en=20
ueber sendmail, sondern das Vorbereiten von mailman.

NEWS fuer 2.1.8 (15-Apr-2006)

{{{
     - Updated email library to 2.5.7 which will encode payload into qp/bas=
e64
       upon setting.  This enabled backing out the scrubber related patches
       including 'X-Mailman-Scrubbed' header in 2.1.7.
}}}

Wieso es das macht ist vielleicht(tm) das "Content-Transfer-Encoding: 8bit"=
 in=20
der Mail von Linus + Decorating. Wenn wir das rausnehmen, sollte es eigentl=
ich=20
gehen.

Siehe dazu auch Mailman/Handlers/Decorate.py  process(..)

Ich habe ersteinmal in=20
https://lists.open-mesh.org/mm/admin/b.a.t.m.a.n/?VARHELP=3Dnondigest/msg_f=
ooter
den Footer
{{{
_______________________________________________
%(real_name)s mailing list
%(real_name)s@%(host_name)s
%(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s

}}}
entfernt. Vielleicht kann Linus nocheinmal exakt genauso seinen Patch an di=
e=20
Mailingliste senden.

=2E...das waere jedenfalls bis jetzt meine Vermutung. Leider weiss ich gera=
de=20
nicht wie ich das am einfachsten Testen koennte (bis auf das Linus den Patc=
h=20
einfach nochmal sendet).

Gruesse,
	Sven

--nextPart3471292.9gXMX0izR9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLULU/AAoJEF2HCgfBJntGCIcQALKgCWJfqxcgy3cQsTJWPq7Q
2CSTrcz1UJjO5sjKWiZZVx7neb1f4FuTX4HkRQucnx9XjViBTYvqUb4KAxJppMUc
SdAYbx5+HDPfeGbDYOgQKhJdV8g1l8D+QiT9KuLoWUTPjt87R+m4dU+rT2fG7m9n
1U1YADevk4lB9z7Y/S3YtRnBC6BEl+2djxiDB2QY1QhQDc0CFlZIXt5Uv1BI8y2r
EAKkhBZKlOgBCxdbBFXUKXAD064hOxn/Wydx7CWXjevfoPxJ98ZMm/caV+UZpNhW
meo4CNaJQcquTpPfHJ0mNoyYJaZ75viZBmD21cXAJNSefLx9ujDkAbpmEVhb48Ti
8KDXJyGzAlQ7QL1TErpcjBh5E5Xx0MZ6PUg9TUbNnv5Wt4Ad00WWdSy9igjbv0YR
GsC9kMMIjGQ4J5uA2hDr0okxLETtamz7sFYIIvzGo3O++HF3022aC04CVbr7+vrT
1lll/kI/VTVv/VR4d20RqFCCXFaOZdkFXP/cIk0Qz8gZUXUFBsmz2EZA3CC1jq77
Nyc0fLWHrbn1bUQryjogDS8J7d8tY+dvNzefgfVkU5Ny/zEnqWF9zIv1R6K2lezU
VXbGItEylTlLBrDgMBTkwqqYvSXSM3mVmkxullKI3iGA3MKo9BP+4oCy9wPI4HGy
MTR2fwEms+rqDxWsiaaH
=c83a
-----END PGP SIGNATURE-----

--nextPart3471292.9gXMX0izR9--
