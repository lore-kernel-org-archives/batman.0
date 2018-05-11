Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 11 May 2018 18:41:28 +0200
Message-ID: <2081288.OWl9LaUEiB@sven-edge>
In-Reply-To: <20180511162307.12255-1-mareklindner@neomailbox.ch>
References: <20180511162307.12255-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2290133.kEnhs37DGX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [maint v3] batman-adv: prevent TT request storms
 by not sending inconsistent TT TLVLs
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart2290133.kEnhs37DGX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 11. Mai 2018 18:23:07 CEST Marek Lindner wrote:
> A translation table TVLV changset sent with an OGM consists
> of a number of headers (one per VLAN) plus the changeset
> itself (addition and/or deletion of entries).
> 
> The per-VLAN headers are used by OGM recipients for consistency
> checks. Said consistency check might determine that a full
> translation table request is needed to restore consistency. If
> the TT sender adds per-VLAN headers of empty VLANs into the OGM,
> recipients are led to believe to have reached an inconsistent
> state and thus request a full table update. The full table does
> not contain empty VLANs (due to missing entries) the cycle
> restarts when the next OGM is issued.
> 
> Consequently, when the translation table TVLV headers are
> composed, empty VLANs are to be excluded.
> 
> Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
> 
> v3:
>  * rebased on top of maint
> 
> v2:
>  * moved changes into batadv_tt_prepare_tvlv_local_data()
>  * updated 'fixes' commit id


Added as e4687b4be274 [1]

Thanks,
	Sven


[1] https://git.open-mesh.org/batman-adv.git/commit/e4687b4be274da6180fc15b327419851fb681ec9
--nextPart2290133.kEnhs37DGX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlr1x7gACgkQXYcKB8Em
e0YkJA/8DTOGbff5BuA2aZCQLkRuWcuUrjAiiIyU+VhIcp/juhBV0l0BAxkBVN7G
tN2L01J/nQhY4BVoRFsBsQ4/NXtv7NuEJ8xppIqffhSZT6b44zSwuFQ0e1bO2wy4
pyAoXcl3Am350LCQXpuAeQDrab/yMCaDcbEt+TohPod4zISiI5MRHk3pSkzKZZ9d
OTgEoqxLVrps765ZKi53+lzH3ki0TzS1pxb7y4flzQDyKgk6GZEwa+50IdXCrf+Z
gz7nwcMr301H+NhZPJ0JvUZwNT/igRrx5CKm0kg2+lMxg7Lzf7mXTPxVa6A5oXrc
qRgiB8JfWJp5SUsjRpMUn4uiursmAvZa9JjWOx76kE0NeEEkI9xfEPB7RmEA02yM
X2KJO/id5TdtiMktoMxXrSs5Ex65kuV+D7O50yFqqZSHUIzJxqUNVj/WgG+Mmmy9
7vV5EBYOoez18odgnsHZDKQ1zApKghrjFFUAq4AOYeL0/UoQdYfFEWu4dgBGNksO
x20vinHDy3QcmV5m9NP7ERdcQQYobthH0tn9NSjxCunFzZja2RkM7oPIiDef0OVF
V22pIueru2xtq8DeDRaLJ3+0+NLM3Ntc7ZVRSgmkrtahfu0ok+9jiB6tIdnPiQ7g
ZqhEx4bpUM9Cs89Mbb67AkKsl8IkAVwPi6NgvTPNySnBZq3SKiw=
=VhJ3
-----END PGP SIGNATURE-----

--nextPart2290133.kEnhs37DGX--



