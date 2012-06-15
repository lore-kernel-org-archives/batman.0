Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 Jun 2012 13:45:11 +0200
Message-ID: <7712868.YW3oqMkdaP@bentobox>
In-Reply-To: <1339705288-4175-1-git-send-email-ordex@autistici.org>
References: <1339705288-4175-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1974676.vJEXdEiiZP";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix skb->data assignment
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


--nextPart1974676.vJEXdEiiZP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 14 June 2012 22:21:28 Antonio Quartulli wrote:
> skb_linearize(skb) possibly rearranges the skb internal data and then
> changes the skb->data pointer value. For this reason any other pointer in
> the code that was assigned skb->data before invoking skb_linearise(skb)
> must be re-assigned.
> 
> In the current tt_query message handling code this is not done and
> therefore, in case of skb linearization, the pointer used to handle the
> packet header ends up in pointing to poisoned memory. The packet is then
> dropped but the translation-table mechanism is corrupted.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> *** this patch is an important fix and it is for maint ***

Don't forget to add 

Cc: stable <stable@vger.kernel.org>

to the patch and a small explanation since when the bug is there (I guess 
v3.1) and that it may lead to crashes and not only poisened memory (that is 
the best case.. but maybe the page was removed and we end up in hell when 
accessing the memory region).

Kind regards,
	Sven
--nextPart1974676.vJEXdEiiZP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJP2yBHAAoJEF2HCgfBJntGnlcQAILoW+id50wfouFA00n2tOmW
SWf+Ty563Pt4fLxauXBeGf8TFE1pODd3fJQUqTec93sLGg7BdSxt9UInbPEyP5qQ
CZL4/6pt8P3qYya0sZGvvlRVqYYH8bKYQ5Ky4p+iPbNCTZGdoh6lxFfddVbTT9RX
6+MEGcgu1cMlqEnxAjv5RRDXKTBEDXT80PVRpyNEiCkfGZp+FZsEu7fT/VAbowuj
mG37DEtlNMT0vrj5+Lf7PJbdV95bMuUOJAmM0dANDMMl4G1RuV7AO4TdwAg7GYxX
ZYVT/FeJ9LCqqdb/au7vtXCQScJek7CLLKjQmxU6NINIKRQCTvfkihoSZpedYcFU
Oio04gdfN8dmqi98JRnbrsS947BgoTC9/lk/Q7yXrqMVVVoRWBYJavuMdFxzjoT6
MnLGO1OTrv1oYONpHt7YO49KrZmI3N/tXLyJk82DJ+3Hn1Wn53CGVeAaQUMYb1W8
gJHSCDgptKLn0oFp0MBmqghy/uMoFvEEocj3kdidRazdLzAgZhbJzLD9X6+YQnDm
5iLhH3SHrZyATlulUR19EfqAK7Wpsx8ZJcHpeMZNY4ExPmd68QvwLBdNlMESK+VW
1fY+b26+6MUTx2+QfSN1mLWG9Mb/CHVZqYkHGh7dhkoqRBTxYRxhRELFT60Qyan7
SL9ZVDuqmGgQCSVxihKG
=V1AY
-----END PGP SIGNATURE-----

--nextPart1974676.vJEXdEiiZP--

