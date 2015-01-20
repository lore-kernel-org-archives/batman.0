Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 20 Jan 2015 09:28:44 +0100
Message-ID: <8724280.PKxsr8UKjR@bentobox>
In-Reply-To: <54BE0B72.1070502@litza.de>
References: <1421705011.612946.10937.nullmailer@sylar.jplitza.de>
 <3346859.V9Mt6glXr0@sven-edge> <54BE0B72.1070502@litza.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3255349.Xm38FnzNbV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Tighten size check on received
	packet
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
To: Jan-Philipp Litza <janphilipp@litza.de>
Cc: "'b.a.t.m.a.n@lists.open-mesh.org'" <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart3255349.Xm38FnzNbV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 20 January 2015 09:01:54 Jan-Philipp Litza wrote:
> It already does that in the first line of the if statement. Your
> modification only checks this earlier, but because no data from the
> packet is accessed before the length check, it should not matter when we
> do this. Or am I missing the point?

Sorry, only looked with one eye at the patch when I came in this morning. So I 
missed the first line.

Kind regards,
	Sven
--nextPart3255349.Xm38FnzNbV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUvhHAAAoJEF2HCgfBJntGhx8P/175Z3ChriucewsUOKocecfq
/Z7KaOi/tqvDF2hey7SE4BM9KK3ZqHaWwmiOHrpa26jyDll7Yavsx44TA/VY9ozE
31OeDngJj0bL3nf4OkjkCEVMrJLgOLgkttQBrSDtAHi65sXWUObKxRgRvDatGnHg
5MyilkdWuAfiptIKNEjaSelD5cBm+iF9atH2i/kw+Mi6m6lyJnHYkk++BRNRUtmx
tnjeUiOI+nEGaQTODgIvujl3K5oVqSGcvojZRrEfk1Mj2IHcbsPYgaLXtOCb43Gk
rwyMCaWxC0cRAztKEzgR7xwvFEGavtCQFQKY9SFP5fnBNbQREFx6aPHF3mUCbfT2
zzCaprw3nxLcUvEJezYS1JxVmi0RYTPNmKxZj5RMzOsWF5gZ68E1pVqcpq4xS1lE
IfjZEOZMnfaaOaY1jGlcsc9UvUPDkLUa8Z2vvl8CPYMBdUKLw/K5LlIHiABhL8pt
ib7s2J1FAyFTK/o6RGvOoYSeBHm11GUUCczgyuCt67dwGiASMsRvtpDW2CBibuZr
99DMnVL+2zO0elGvua4l/s7eMSO4XwEfLHSQglAPt3/645MQFz9DyVgvO6Hft25U
/szDcf/lEZ4rMt5F63CWsw43qvwQtOuFwSSZ3DkzHHY1QcMwxmDPWa7QQljeoEqF
urpp6mjLejU6zfyoneK9
=0vav
-----END PGP SIGNATURE-----

--nextPart3255349.Xm38FnzNbV--

