Return-Path: <tobias@hachmer.de>
Message-ID: <53D1468D.9080403@hachmer.de>
Date: Thu, 24 Jul 2014 19:46:53 +0200
From: Tobias Hachmer <tobias@hachmer.de>
MIME-Version: 1.0
References: <53D00BAF.9070506@hachmer.de> <53D05D84.20700@altermundi.net>
 <88409a9ed363089a1dfc08d0baa9dea5@hachmer.de>
 <201407241101.34652.sw@simonwunderlich.de>
In-Reply-To: <201407241101.34652.sw@simonwunderlich.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] alfred - one gateway - multiple interfaces
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Simon,

On 07/24/2014 11:01 AM, Simon Wunderlich wrote:
>> As I said, a workaround could be to just simply duplicate the
>> init script (adjusting all relevant names like pid and so on, of
>> course).
> 
> I'd like to point out that you'd also need to add an option in
> alfred and its clients to duplicate the unix socket used to
> communicate between alfred clients and the server - currently that
> is hardcoded:
> 
> #define ALFRED_SOCK_PATH		"/var/run/alfred.sock"

Bad news, would be great if an alfred developer could make this
configurable passing a socket option to the daemon.

I'm not a programmer, so would be great if someone could help us out.

Regards, Tobias
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCgAGBQJT0UaNAAoJEHXGlTiIv2V4NTgP+QH3VhxUz4xx4cAPQbJfSOBn
mrfAVWe/3AiOYOuk/b1cvzQeQH7Ae/i5a/JpOChP8t6T/p2V6PMCLlw2PfUJdLCz
/D+CqhwCRNCRi5zAINIrrhD5sQDiFe+L5owvicZ5Uy6qOIrqReYLgJ2Wh/5rSRsV
QSAWdxsMSuHbuwzvylfWwg1NsUs0YsFtdTE3n7Uo+xTs+I7b01rbbnHnC4Hj1JKG
3up0e9bwtp6UQO4EH1hmfiz597/LvP+3b4ojwAYXyHtm2ObxaBWMfm02drWfXKyW
uk2jV3qOBaWps22go3h08VV/dXehTTt7uGF68rVFj+/s7F4IrenfGPcMWvaGk+et
DjcLZvTf7noC9miSFxVZR05UrY7w2uDqyGQ0lCtEJbHs+wSD3Pa4f9xZeUEZOHeL
QK7ZWf+3qO0ey8jQ8cde8AR8O0EhYOIuih+nnJGEuK+zU3vELnqbD7Bs80DqjFSR
yoK3PKiMe80E3Nux93BbF4UDDWzCqPA/JtSzE9cdsQVBjQpbAuCY2BrRzFGxrg/h
VI/EouXu/qk8gzDDxkykgWrXggNCLkvL9Q1waePe2/7HTTHqs3fwZ+NqXIJzfUP8
Dc9EVu0maidfTH8UZkPJTLkFRr6l8pEoM4c3UKNbFZ2EpG27Ky5vFQtpfho9/mNo
nzSiALthFbfxauZXRMGD
=2Gnv
-----END PGP SIGNATURE-----
