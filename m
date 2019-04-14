Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 14 Apr 2019 16:39:24 +0200
Message-ID: <2914505.aB7mJKbZtp@sven-edge>
In-Reply-To: <c4ee398f-5654-2057-d870-4ba5c6bf29be@ralfj.de>
References: <c4ee398f-5654-2057-d870-4ba5c6bf29be@ralfj.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4729259.nZr3BGeKkE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv release mailing list or RSS feed?
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
Cc: Ralf Jung <post@ralfj.de>

--nextPart4729259.nZr3BGeKkE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, 14 April 2019 11:10:11 CEST Ralf Jung wrote:
> is there a mailing list or RSS feed dedicated to batman-adv releases?  We are
> running latest upstream batman-adv release on a couple of servers, so we'd like
> to know when we have to (manually) update our machines -- and currently the best
> I can do is try to remember to check your website regularly, which of course
> does not actually work in practice.

There are the news on the website [1] and also an atom feed is provided.  It 
is even possible to subscribe (watch) to the open-mesh.org project news on 
Redmine to receive mails when a new news was published.

Or you can uscan the the source download folder [3] like I do for batctl in 
Debian [4].

Or you could use the feeds feature of the github [5] and gitlab [6] mirrors.

Or a couple of guys come together and provide a repository with the newest 
package format you like (with DKMS or prebuild binary packages). And then use 
tools like (on debian) apticron + apt-listchanges + MTA to send mails to you 
whenever the server has to be updated. Of course, still means that someone has 
to follow the news but the rest only have to update their server.

Kind regards,
	Sven


[1] https://www.open-mesh.org/projects/open-mesh/news
[2] https://www.open-mesh.org/projects/open-mesh/news.atom
[3] https://downloads.open-mesh.org/batman/stable/sources/batman-adv/
[4] https://www.redmine.org/issues/1521
[5] https://github.com/open-mesh-mirror/batman-adv/tags.atom
[6] https://gitlab.com/open-mesh-mirror/batman-adv/tags?format=atom
--nextPart4729259.nZr3BGeKkE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlyzRhwACgkQXYcKB8Em
e0aQ6xAA2AiwfITMQiVyOITh6A/HkFws2TOmTklp0t/r2z8UYQF1vGRChAD93RWR
Glr1ypaqWlHQJVYcuwTiBC4XYYwzI7JVngvUG9FtYFxLTkPZ4Yxz1kRmqbj9mtCt
QCNfFXRZNGxOK4rnr1IfpYt2dVfn2Rm8Qmt2YUtQAEWqVQ0XAhfNuiAu3VaZ5X2N
HWLfXItgpwHPwtsyuc4XcKDVC5/oq3RnTo/fEeKDndhm7ps8qBL5YoMd/1Qg7UuF
w/3L1n5NR/IbNgC3f2Vuf4uVmNLu90gLYKwDrf+xbpDWkxBtZq/5JDd/KagdRC8u
ngnob98BT5NPjwnWVqFYNdnQSblThWSYVrZJkgdEfgzTI/Z4qHm7tBsuk/v7fe9J
I+F0yB7Sg8e1hvMfmGqxxqL9AQrbu4/86GrFFt/4YnCIzEJ8mg98hfmcdhZHa01M
pX7W2zb2+U1f0CkUarjRqpQZaR7RALdK9QDo3iC+fEP8ArJWIiRaKsN/8RNOfweg
PY+hdStNYPrm0h31WNW60Yvde0Zjg4NF501f2rRV/P6zUP6hN+tVtmj47AidgvFK
uPwL5Jby8o+fHRawFqNq9BSbx89D2x4+abQ23QEFjyRvddF8KYeExsOGkPrwg4Lj
7jQc3/fAV+ujasJj97GZTyvtPMbHSaYMhHWP4Vave7Wqzx4rpcM=
=M6Mo
-----END PGP SIGNATURE-----

--nextPart4729259.nZr3BGeKkE--



