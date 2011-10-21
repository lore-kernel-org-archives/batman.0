Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 21 Oct 2011 12:24:50 +0200
Message-ID: <16700702.r6raFJKRXY@sven-laptop.home.narfation.org>
In-Reply-To: <1322573.INJVHFxvSp@sven-laptop.home.narfation.org>
References: <1322573.INJVHFxvSp@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6565208.trOETCvxyd";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Fwd: angry batman after sleep
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart6565208.trOETCvxyd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Hi,

On Friday 21 October 2011 12:14:10 Sven Eckelmann wrote:
> i get a problem with current batman after i resume my machine.

Just as small note: On IRC you said that this is batman-adv 2011.3.0 and not 
2011.3.1

> I can ping this PC with "batctl p" but i can't do it with "ping". With 
> tcpdump i can see that, there is no ARP response. I tryed to set bat0 
> interface down and up.. without luck.
> If i try to delete some interface from batman, i get kernel panic.
> The part of this panic you can see in attachment.

Please update to version 2011.3.1 and test again whether you can reproduce the 
initial problem. Also try to apply following patches from the mailinglist and 
test again if you can reproduce the second problem
 * batman-adv: remove references for global tt entries
 * batman-adv: add sanity check when removing global tts

Thanks,
	Sven
--nextPart6565208.trOETCvxyd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOoUhyAAoJEF2HCgfBJntGyA0QALKKqYIZh1uaNjKQauTl45ar
lBUWZNan0uUDt/6Jy+pJA2nV0Gct5YltKFHb/a1igSWPz7loQfSO2R56EugSkYgO
hpdlc+TDF3XfM58C/SmyaQ2xruXgVS1dLas7oUWTSzBTX7CsUSsWcLc+pO8daxPr
QolZeGJuT/jg1YwGljeHoJg/re/pP4MXq3z53sb+dP0WwywEhsT19AKcPw3N3pDV
4A8TVIoXcrJAyQvmzjn8+KNfuSnfjiB6WoHi1VavgWWIJ5eW0lGKkLmEUmSSEEXO
WqVO6mU4wqerkIbYdMQxGjvHdWLVHPfEaMeZgsWEmE/+oKBcwRKRt6JO1tZauRqR
buGF7CpNEnVYBfjEo4TUcZFiv2KT9qoxy8E1zlG0ry26SBzraWCyOQcERV1fUIe0
XjX7RCHHmL7mM66DlJu6dxXCmXBbN+wZMTRwdSY+gjc1UwbTrkfr3QhSTNcxqsh4
a1vQDYmqow9fvj4yzZa0MIDewdvr1Lhg86GprsT4FNPSywJjSJS5+9QtPqLiVfT8
gepgkSHsS2ILVzzJ7thx0Uhxqsm2XcwLcGFut4Xze1sy8N0+RhBQ00UGPv653S/Z
L4dgI8P7SYzSPuTyWEpHo9gun7baTtS5AMQ7TAU5SOsdvJq1ID4+ZrMKusEVF2wK
oKZV6ezszOIQsmSOAf58
=mrWp
-----END PGP SIGNATURE-----

--nextPart6565208.trOETCvxyd--

