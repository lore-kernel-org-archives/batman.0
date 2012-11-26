Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 26 Nov 2012 11:10:58 +0100
Message-ID: <1421529.CDZ816kfjh@bentobox>
In-Reply-To: <2094937.nutMCHjP7e@bentobox>
References: <1353867811-8452-1-git-send-email-sven@narfation.org>
 <20121126093309.GB22729@ritirata.org> <2094937.nutMCHjP7e@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3482847.VbqLL3QeyW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: Use common Jenkins Hash
	implementation
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


--nextPart3482847.VbqLL3QeyW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 26 November 2012 10:40:07 Sven Eckelmann wrote:
[...]
> > I don't fully get why we can't use this new implementation in TT. What's
> > wrong with the CRC computation?
> 
> The in kernel implementation will create a different hash sum -> tt entries
> will end up in a different bucket -> CRC will be different (please correct
> me about the last step... just had this problem in the back of my head).

Just checked the code and you are doing an XOR of the crc16 of all TT entries. 
So TT can also use the jhash function. Will change this stuff in the lunch 
break

Thanks,
	Sven
--nextPart3482847.VbqLL3QeyW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQs0AyAAoJEF2HCgfBJntGAhIQAKyiwrgO/JpDoAHWP0SWOKI+
xRadcTLHplhldvK5CcBt7BdbIJqjuLwEkxTbAlcOFU6qegXBev2cbQicAhooNYWI
e+7nf1oyAXvObqQJbt0+p1NWNQ1VaV7rXCSiMdR1uPZixuQHtXDiCvEF79unSxGH
oJZYK6mAcXhZybunoWiR7ErBocx2k4hcoPVnwE/0kWBnuSE62f5dfpnADI7714Sd
NLGMItkrJvfIdYTyMatFt+DYOVoy1fI6dOehUCt3bgZFptEw9eOEMVuCN3MQ6h8z
zOTIo9c6NmXlnm5EhelWE0cSkiSo+lh7SDf2dP17aqPJQq37/ULR5dQV2iSRFHV/
IJgqyS5dh1vEAmzpsIbQDaafF8honwEkL+axKXcmixX/bZfDWc/SofZW0K9qJswZ
Nz0v0gVSQQPxNjoErC7qI1sq4p6qqtut9Dydm2/teaKwHO76AQph3aenTXGhsMO2
eypsV4ufDK9Ga8psG8cXu8ip+hYWY8ce9WF3XJB0fcIVnF/B/hyVsstxvAXRxCR/
aECgG69vcIhKp5oSFa5tpswUW0Q1pdNrjMPvi+ckr/4KxTZorphMbtzasms9sZx4
zlUFaeWRA4bOptlkF3JDqLOYGux3qSOf2cguAAQoNJs3eTIILvGindYE5j7Hrkty
snQraiW78MDlHh6/4got
=JeMt
-----END PGP SIGNATURE-----

--nextPart3482847.VbqLL3QeyW--

