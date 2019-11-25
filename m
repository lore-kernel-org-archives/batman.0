Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 0/7] B.A.T.M.A.N. V - fallback to tp
 meter estimation if throughput otherwise not available
Date: Mon, 25 Nov 2019 09:41:52 +0100
Message-ID: <1733664.4DtWKhy3NH@sven-edge>
In-Reply-To: <8046301.0ldSNLAhfO@sven-edge>
References: <20180907095958.30946-1-mareklindner@neomailbox.ch>
 <8046301.0ldSNLAhfO@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4305636.8bLP59jsSi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart4305636.8bLP59jsSi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, 8 September 2018 19:38:01 CET Sven Eckelmann wrote:
[... explanation why this test could create problems for other wifi connections...]
> Is there anything which I missed that could ease my mind?

Beside this potential problem, there is also the problem of the interaction 
with the ethtool throughput gathering (brought up by Matthias Schiffer [1] 
and Matthias Fritzsche [2]). The ethtool code basically prevents the correct 
measurement in many situations. I will try to summarize it now:

* ethtool's link_ksettings is not about speed towards a neighbor behind the 
  interface but about either

  - PHY layer speed class from local ethernet port to next peer (for direct 
    connections)
  - connection towards next (internal) switch
  - propagated value from a lower layer device (e.g for vxlan)
  - "random" value (e.g. tun/tap)
  - ...

* often connections indirect (switches, VPN, WiFi bridges, L2 firewalls, ...)
* B.A.T.M.A.N. V requires a measurement for the throughput towards a neighbor 
  and not the maximum(?) PHY layer speed of the first hop over the current 
  medium

The proposed solution is to drop the ethtool link_ksettings usage when the 
tpmeter (or similar) approach for neighbor speed measurements is integrated.

Kind regards,
	Sven

[1] https://github.com/freifunk-gluon/gluon/pull/1872#issuecomment-55767698
[2] https://patchwork.open-mesh.org/patch/17371/#31059
--nextPart4305636.8bLP59jsSi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl3bk9AACgkQXYcKB8Em
e0bfhBAAgHnXyhIUkH1p9YfikIU3Upo5eFMKZlfVejYpVME4Q3k47LZ3yzmdHPo/
zwmNY44A5cUl6ABFzOLiz4sJbaBdE6RWMAHV+dwZVlBqSc3y8ZSy5GnjkTLELcLm
LsBNbmB69DzwlOCh6JjTiQx5CNox2wjb2kuDSTCTGB0qZh+jTo0ylyrWX+maf0Cs
bg4hN3q1Ba9bXlmYcC8IZ0/3WsA9mpWoqBQO0GnBC2ISxGqagYMHYqewJoKohEmI
wetPXs/c8wf547jIiuz+ph7epQreCQ/FKB5TLMQq1+BKHnWMlh2SnzesS5I4gKb6
dd4PdYdDAF+/M2kHom+m8q7QKAVjonA30O65gvw0rhfEiBZn+BQDwrRJw7Ae5670
fFrhY3/r1sMSHewu0h40lUkrhTkVmjCwu3reI/6e2wBBoLKLB1GnmVS8QZflEOBO
SBinp1inhRaLyC+hUfX8WHuTjoMnjW9XHUWbLOMkgnIoMGpYUr/S4kfZyeJCPQ4j
K/xMRYGkGhyb76Bo0O50DvkGofma//tUV/7e8g/2o+8WmfiPBhu0mC3jscoqp0f2
Nc2WIgRcX0A1JBV1VwOREa1MzNvSi1bF5EpfyuAeK7vz3nIroc3pVvMhpEy5NDDE
Rlc0Uu1KbG270R2E2xl/O6X0FDW13bjEuQGIbym1SyryNnZIGt0=
=U5pH
-----END PGP SIGNATURE-----

--nextPart4305636.8bLP59jsSi--



