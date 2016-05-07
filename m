Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 07 May 2016 15:14:18 +0200
Message-ID: <1814301.UWOsVB2eEq@sven-edge>
In-Reply-To: <572DDF9D.4090609@wifibot.com>
References: <1462566429-26709-1-git-send-email-sven@narfation.org>
 <2142847.UKtbylqlvC@voltaire> <572DDF9D.4090609@wifibot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3011397.PvaPGTFi50";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] no able to switch routing algo to V ?
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

--nextPart3011397.PvaPGTFi50
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 07 May 2016 14:29:17 contact wrote:
> I just got openwrt 15.05.1 with batman-adv 2016.1 on 3 picostation HP,
> this time a selected before the build of openwrt batman V option, I can
> see it when it ask for available routing algo ,
> 
> root@OpenWrt:/etc/init.d# cat /sys/kernel/debug/batman_adv/routing_algos
> Available routing algorithms:
>   * BATMAN_IV
>   * BATMAN_V
> 
> but when I do :
> 
> echo BATMAN_V > /sys/module/batman_adv/parameters/routing_algo
> 
> It does nothing, still on BATMAN_IV during session and on reboot ?

Please don't hijack other (unrelated) threads,

Kind regards,
	Sven
--nextPart3011397.PvaPGTFi50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXLeoqAAoJEF2HCgfBJntGBBwQAIFQ7ZC/PiY4+zAMtS0FomIT
IRUXvdmrCICe3PLPoAiJTEpD/Q9STnukF1NlqQxEkbzXBOwil2lvKHrO5TqyipBM
XWLzwXLT5/GJg696HA3G67U5WqICZqY8uL8DW1DyZaOMxr8di30fGqhUL+EcOpXP
2IwTzNMmACM+1N6z2BnJkLPb/GqT5/sIlQi61fX41LEsVAq1miwl3yORCgJqfOrY
KoaGuGz8bTaZtwQyOMECJtsmVZ0vystF11/OnZCy26Qzs4mqt88Z/Y25ogEQM3io
1IO0xYxScwH7wpOjZ2R09mqVtvGbyGcZhTDch2rB81n4VLxkUIfZ2fJClEZDV5vH
MKYAINcl4zq591Ov5Kj19eY2isLPHUHmqras4sP4ZOh2JP3f92pQJo8qwQOQG8VX
D4B68xnZzVFgA/i32TsHs7NiuRL4qF3wgW21xVxIS4e/6mwEzGh+QKDPVwlRwfib
Nw+Jf9oyMqxi1HSdSfuOo0UJhDfRsxKV8SKCxjjwFldV29b5EgZwNP7lV+xbvtrQ
u9LykOUWmg+nV5He46CsHAc/W3rsJC0jmgK0rF2aZ0Oag60lWnZ/nZMi5SSbhZ/m
BrGy8HIHLWDkIx9CLRi5MCJXlCArcI9sMddmQm7LlaflmaRKCuWsPXSPsHWuEZ33
buHBWDtDP9S+npzwDqpn
=V4s4
-----END PGP SIGNATURE-----

--nextPart3011397.PvaPGTFi50--

