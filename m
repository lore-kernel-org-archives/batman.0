Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 20 Jun 2017 08:33:33 +0200
Message-ID: <4541231.cHCCYZPiDH@bentobox>
In-Reply-To: <OF851B1547.E69BF39C-ONC1258145.001F7A29-C1258145.001FFF17@phoenixcontact.com>
References: <OF851B1547.E69BF39C-ONC1258145.001F7A29-C1258145.001FFF17@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3943966.zVXaI9mDBU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv: is it possible to increase mtu size
 for batman-adv interfaces?
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

--nextPart3943966.zVXaI9mDBU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 20. Juni 2017 07:49:28 CEST Andreas Pape wrote:
> Hi,
> 
> currently the mtu size of batman-adv soft-interfaces is limited to
> ETH_DATA_LEN (1500 bytes) in function batadv_hardif_min_mtu as far as I
> understand.
> 
> A comment in this function states that batman-adv "does not support MTUs
> bigger than ETH_DATA_LEN". Is there a specific reason for this or would it
> be possible to increase the MTU size to something like 1518 by simply
> replacing all limitations to ETH_DATA_LEN with a higher value?

There is no protocol specific reason why it is limited to 1500 bytes. But I 
think there is more needed than just changing all appearances of ETH_DATA_LEN. 
For example, at the moment we don't use more than 1500 and thus we didn't had 
to overwrite some of the special netdev variables for the maximum mtu. Maybe 
someone remebers the patches which wanted to touch this part of batman-adv but 
which were then dropped because batman-adv was only using an MTU of 1500 or 
less. Here is the revert of the change which tried that: https://
patchwork.kernel.org/patch/9390379/

There is most likely a lot more which will cause some kind of problem.

Kind regards,
	Sven
--nextPart3943966.zVXaI9mDBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAllIwb0ACgkQXYcKB8Em
e0aHdhAAyzIaAO9HpDEJH7D+wHaUcgRaiIqI7Y/ew2CNTbxKeJsZpwiy7/DJ9qdA
Z/e+xlRUlK6wLBJPs4wvEWo8Hk6y3VAZZiEa3Xd+IORBkqqLqkTCKtpcR6ZAFZJA
FoIC4APg9Y6n963E3ycLcKyQAiVMy6U7qh8tZ+/xeBLb4aFN7VIBUI6vUSYJK4e4
2CIlntuIMCTMHvq/sYQvEKQVBNj601z1zBxfxU8/i8fDQKBy9o7UWF2p5Jfsbra+
yR8lgohYcefQKRbCASezUwTfUOZlVeLHvEoGDhJZ9z81afE2oq3g4JkJgg1wA3VW
DiN7iTc7SAlLP5dGQwIwN8YPTKXoCWnAkJsXE57JEwy10II5um2WUKRwmxr7/ujt
/qhyLihHLvmIt+0f5qAG1eKcHrMipKAQ0suS0uyb3V6ra8oRk/lZrvU3ER07b/QE
rRtPaLEvy2lGXteuoLPmgDTtxKzBn3kihH3WU0MYNPo/9AVq6gGOGXzcd+cQI4iC
r6qau8+5zOmAkRpM7oDWqV9vi2v5Ga+zhWaLCll7M1gm5wsvjfWWXgkKSu95V1Wn
lYEUQ8nP4lzK6XYQ9QjJ8weYO+6xwTwk4egT3kKxKaBcJ8mbjcDFdnmAB0AMga37
bSjz1eU4BYSIGQjiki5K/FzN5eADqcSAEDJ9bT1242WRZtwu6Ns=
=3Nsj
-----END PGP SIGNATURE-----

--nextPart3943966.zVXaI9mDBU--

