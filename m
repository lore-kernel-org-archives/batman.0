Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 27 Jun 2011 10:15:18 +0200
Message-ID: <1420378.ZNDDy6Tuoz@sven-laptop.home.narfation.org>
In-Reply-To: <BANLkTi=cK3LA-563FvccPOH8eZoXHurysA@mail.gmail.com>
References: <BANLkTi=cK3LA-563FvccPOH8eZoXHurysA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart18440909.PhenRuYsvj";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.1.0 network interface setup
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
Cc: Max Ip <ipmax2011@googlemail.com>


--nextPart18440909.PhenRuYsvj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Monday 27 June 2011 09:48:38 Max Ip wrote:
[...]
> I would like to run bat0 interface directly after restarting the
> computer (like we have it for wlan0 or eth0)
> 
> Could you please help me how do I do this?

This is a task for your distributions and we cannot help you here. For 
example, I think there should be uci support for batman-adv in OpenWRT. There 
could be support in other networking scripts of other distributions, but 
usually there is some kind of "user init-script" which is called as last init 
script so that the user can make his own modifications. (On Debian this would 
be /etc/rc.local). You can just add the commands needed for the setup to this 
file and it will be automatically done after the system started. Some 
networking scripts also allow hooks to be added so that the batman-adv device 
can automatically be started/removed when another network interface 
appears/disappears or gets/looses a link.

Kind regards,
	Sven
--nextPart18440909.PhenRuYsvj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOCDwWAAoJEF2HCgfBJntG/QcQAMj3jAMDa/LGEeQrNRdY8so0
/INUOPvTuCwloshfI3FdOq6EPYTdB97UckOSMkVWZeEvUGcHErpvTsiGuvy7TnD+
uzSxR0idimQAE5xa5V4C35dRcupG9pL9551m5yEzn/qduDjzQU6pv7oSrRHAwT7n
ZZvXHBwfRi7civ9S0pWFsfDtwnPQU0j1AUBjjAWXDTL4ouAD+r1g41bLhBVAZZbw
Nc26apUlDhvOH25rnU4kWM5tm1SaHpZWfS++OmKqpaS5h8rf+NeW8rKpOvL6OCyO
RZFJJyxlsu5pyyjZNoC9xTlhec0SqD/7KmHVJp1Ag0CpatXtqZBQIzSQBoJzyIpy
UfpsVMm0f4q50RdSlqaop2ms9mDcu3D3eLOezzM3apZvbp1YGPko9JQfUAAzRlbU
zhPtrgC2GrQe7yyvGBTUGYFYzzZs+6DxcOR0UZpzW/JI9thBjXrC2o36k5WYwdzj
80FkzJnKkEzyGcKNZuKOdOqHWKqaFrJ+drQfpKmZ/HzK6jNgnmrZtfnLMLdv2ki4
pqulBXP+7pWQf3b6EphRTA6dDMYiGuzAA+s8+1KD/SWSNvO5mnKsPgc5+zcOMJrY
VGsEQJTzM9Wo7/332Zcu3L8olBkvTudrJ9FsNSp1jmF/olgIzTKTIq9Ge5z5bm/1
Hq1vBREAKYJT8YUAzYHp
=FqHH
-----END PGP SIGNATURE-----

--nextPart18440909.PhenRuYsvj--

