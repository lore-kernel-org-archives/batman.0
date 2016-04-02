Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 02 Apr 2016 08:15:47 +0200
Message-ID: <2105035.hUCDNLol8h@sven-edge>
In-Reply-To: <1459513651.4076.17.camel@gmail.com>
References: <1459513651.4076.17.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3812805.HtNlC8BtE2";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Need some help to understand the code
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

--nextPart3812805.HtNlC8BtE2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 01 April 2016 14:27:31 Philipp Psurek wrote:
[...]
> If you have some spare time please recommend me some literature that
> has helped you on your way to write batman-adv code. I've two, three
> weeks to prepare myself and evaluate if I understand the code (or some
> parts of it) or participate in fixing some other Freifunk related
> issues.

Hm, I cannot speak for the other people but I would not know of any book which 
would prepare you perfectly for writing kernel code. The best resource is the 
kernel code itself (LXR is your friend to find things quickly) and the kernel 
documentation (e.g. in Documentation/*). Also the Linux Kernel Newbies [1] has 
some nice overviews and links to more information.

There are also some books which are well known and can help you to understand 
parts better [2,3,4,5]. But I think none of these are must-reads. Having some 
of them to find out more about a special topic can be helpful. But don't 
wonder when the example codes don't work anymore because the API in the kernel 
changed since the book was published :)

I don't know what tasks are currently open in the Freifunk GSoC. But if it is 
multicast related then you may better ask Linus about some more literature.

Kind regards,
	Sven

[1] http://kernelnewbies.org/
[2] http://www.kroah.com/lkn/
[3] http://www.oreilly.com/openbook/linuxdrive3/book/
[4] http://www.oreilly.com/catalog/understandlni/
[5] 
https://www.kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook.html

--nextPart3812805.HtNlC8BtE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW/2OTAAoJEF2HCgfBJntG8uAQAJa6xD2iVjgjjOES69s79kOi
F99zMuFkaVhqjb0Kt/BUOx1Grx6HZZ+ek34IICJNWCcqBIH5bb2UvCSuolACDzec
o0dPbdCqAsZxiccyS9dsovS19etMISjiUKlL2518+jD0jUMiISs7e2WLBcPkNoiZ
5G5PgJbTGDeBMgjkcCj/RR38DhkN/MFRcdBru5dZHVEngq2Bk4M+esGLrd7XXgNi
Gk6UBb+RWuFFXouoz0oTq4A72kMJd/j7eU0W6/e9D5Dib1/HdUDNSwujqh6NYyad
/kV7n8W4GGEi8YU9mVgwBUfsHg4NaB6plrMNjlQTkPY/3srBEDcfwPwa+MTZI0hJ
Hi5fhzl6uCOR++7jt90zanAE9yoyhWmcbGs9JxS26lsPn1aGGnKNcfW4MrT5i7Fe
RQMOz+UbRmtMbl+JiEsutukFVGr0V9H2QIQNudcJKCLAAp0cv5UIRVAEio+jSkSl
Z1ed5YuNvx0AsOc1i7OOst0alrVtsd5qIerMK/zq+iiPx5Ao6GvnAtZ+W5N6I+Tc
rzL11CLC3dSGGGU+Tnq232HhpyediLZsn0/X0TWWX+U0qoaWdQk9s4IcHQXFcicN
N4ch+1AxlliLLKXj1DvejobjH/8E9ZseQj8MzmuXFqG5IeLprgOhOc/LAdOwOJAs
gCIqZUQNatTv0QY2a8tS
=tH2L
-----END PGP SIGNATURE-----

--nextPart3812805.HtNlC8BtE2--

