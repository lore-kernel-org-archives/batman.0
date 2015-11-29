Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 29 Nov 2015 02:17:59 +0100
Message-ID: <1696819.DY2yIRgCKv@sven-edge>
In-Reply-To: <29580650.TaMGDDyOBU@sven-edge>
References: <29580650.TaMGDDyOBU@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1809413.sfdAykUpRP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Invalid memory access during if add/del with
	multiple interfaces
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

--nextPart1809413.sfdAykUpRP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 29 November 2015 01:37:21 Sven Eckelmann wrote:
> [...]
> 
>     ==================================================================
>     BUG: KASAN: slab-out-of-bounds in
> batadv_iv_ogm_slide_own_bcast_window+0x298/0x376 [batman_adv] at addr fff
> 
>     Write of size 1 by task kworker/u4:2/67

The reads seem to be solved by the patch [1] which I've sent to the mailing 
list. But this write looks more interesting. The problem seems to be the 
missing locking for if_num + bat_iv.bcast_own/bat_iv.bcast_own_sum (with 
bat_iv.ogm_cnt_lock ?) in (or around) 
batadv_orig_hash_add_if/batadv_orig_hash_del_if.

And I don't know right now what causes the GPF but it can be reproduced (just 
takes some time until it happens).

Kind regards,
	Sven


[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-November/013836.html

--nextPart1809413.sfdAykUpRP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWWlJHAAoJEF2HCgfBJntGZYkP/Rh523LG5g9OfzL+SoYlH3kw
CJOz3dqAbUGPRcuk5bC0I9SQqRV2NwlEKpDTmI/JkgLQufzsmhncWFWewzYuk5m8
jrs2CyyAxZj3/axar15M0JH0HmW6OGY6xO/L5H1Fx2KNhTb4SnSFbFCrBXzTdi08
k1bd8Cyc6oa43wWxC0L/i93CAFFo+1xUP9HnnstUeC6WOw2LOl8CHCvXXv0say/7
mjtBjK6xoUz+EZmEwbeuCBK+RO5WJzQbG5TNplhxMFqNgIKDJb5moMp6GsOHgvxn
uGyUWk1bdmRY/wVsJh18iD+3mAyw+3ZUL66ybJJlIX80unr/Td9qeapmxjT0nn/I
8HiditM+1EM6HiJ2xns61DjThXMG7trwrM/LCCf4zjuBHPb6cA54MM2hecBtXzil
h6pbemNmD7qLFGcuxB+zZ7R0JrmfAdbt3Z1d2+VlMX6OLbSzda3e48VdE53gDUYr
ntkHiq5J5PbbcFuCqwGfatMCb9YWYIqVH/NkvzW+UtvQnWtsjHQPmfrkUjEY75l2
3nXJjV5UsHQDG5pyBGF/EQKPI+go+cptvRRJCbCej+K7BkP3rsi649SYGeRK99nc
0qtnMpgaOXSW7YIlDH37BcVjVU6FZ7FI2HQJKvXKZOC4U/nv3fz/0muL7jzHsvLu
1l3OKijwkGhLX+l1JXmb
=DCTf
-----END PGP SIGNATURE-----

--nextPart1809413.sfdAykUpRP--

