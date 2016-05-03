Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Tue, 03 May 2016 10:18:50 +0200
Message-ID: <17410440.33Me94yB3F@bentobox>
In-Reply-To: <20160502172828.GZ11201@prodigo.lan>
References: <1459508076-29674-1-git-send-email-sven@open-mesh.com>
 <1459508076-29674-3-git-send-email-sven@open-mesh.com>
 <20160502172828.GZ11201@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1858205.JrLx9EoDiN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/3] batman-adv: throughput meter
	implementation
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
Cc: Antonio Quartulli <antonio.quartulli@open-mesh.com>

--nextPart1858205.JrLx9EoDiN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 03 May 2016 01:28:28 Antonio Quartulli wrote:
[...]
> shouldn't we propagate the value saved in err to tp_vars->reason ?
> 
> We found this error while using the tp_meter, because we tried to run it
> against a non-existing originator and batctl crashed.

Yes, looks like I've missed this while reviewing your tp_meter code. Was
the crash something like:

    root@node02:~# /host/batctl/batctl  tp 02:ba:de:af:ff:01
    Throughput meter called towards 02:ba:de:af:ff:01
    tp_meter.c:198:36: runtime error: division by zero
    traps: batctl[246] trap divide error ip:410f31 sp:7ffea78512c0 error:0 in batctl[400000+18000]
    Floating point exception

I will most likely add code catching it in both batctl and batman-adv.

Kind regards,
	Sven
--nextPart1858205.JrLx9EoDiN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXKF7qAAoJEF2HCgfBJntGkvAP/1w4YLNsaHAxUyKHAZJnGCvS
zCPYx4bbrHzaQj/9FKKLyPn4p3aeiEtBUVanPncrJRvCIpmU+/B6rYH1u2LpId7e
qMxkNwNexTX5vOQ32QSUgqHXo87IhfgtZQyPLWcuNzz+W6Bt8T+YX3AXRYAaFHWu
Qsf5v1J5jfj+vKl6CaUhONi2SniH9+ktnp+2zkLtP9IfY0wD4uWrhrIaDbSiVYvu
TGWhHGYAuoR6JvtxdtzvSttfddOScA+8EcxjuvDy5gyaX+M4qAV8RMRXNleVNggF
62m66w1bFfPfPxa0msIWvWpqiUpdzESo0oUxV+pg2M8B0yz2r9+KChbqN+Jj5204
+IzIyFRrOjupSuya4k3ROcndAIjOuCJGFgMhXR8LAXmLnHIDxH5U9m3aGKGzic+7
eQYNdDf2rZF1pf7HNEtDmPCfpezxrkg8+jm1fdOT8oowtUeGyQFNnTNV85BkPJGl
bspUecS9DDtRZwBmiM7KYHwKLmmmZKky7g7SM03FczTeNcGJLCQzvBVk0r1hp/Ch
eLk1nZT2G6aPMir/Skml9TsUICpVEcRUYHcyTTAtTQkDQ/Vo3BZVzs9RjvbmcmLQ
hmWdIg1dn7Z1O3hMTPvD62cvJKZTr8kdLmsu3uQB77Xb4io0g5n2rnqOmhse8DH7
BOfq3/PK9KkKH06ROZz2
=mMJi
-----END PGP SIGNATURE-----

--nextPart1858205.JrLx9EoDiN--

