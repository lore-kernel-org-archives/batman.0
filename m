Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Callback Function
Date: Wed, 28 Apr 2021 08:28:13 +0200
Message-ID: <3500965.S1Hpm5EVt8@sven-l14>
In-Reply-To: <pYxS_SbGp4jLwzdYJKID7uwQCI5M1s6eTc1Ib1EohCNZ1HeNzc341ewCY15CatPmfxur4rEV3i6KhcKPlcU_CcxpS5_VSTLwbM_OrYfIaWM=@protonmail.com>
References: <pYxS_SbGp4jLwzdYJKID7uwQCI5M1s6eTc1Ib1EohCNZ1HeNzc341ewCY15CatPmfxur4rEV3i6KhcKPlcU_CcxpS5_VSTLwbM_OrYfIaWM=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1987721.Iqeva8pZxL"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Cc: BrainGeek <braingeek@protonmail.com>, Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>

 
--nextPart1987721.Iqeva8pZxL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Cc: BrainGeek <braingeek@protonmail.com>, Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>
Subject: Re: Callback Function
Date: Wed, 28 Apr 2021 08:28:13 +0200
Message-ID: <3500965.S1Hpm5EVt8@sven-l14>
In-Reply-To: <pYxS_SbGp4jLwzdYJKID7uwQCI5M1s6eTc1Ib1EohCNZ1HeNzc341ewCY15CatPmfxur4rEV3i6KhcKPlcU_CcxpS5_VSTLwbM_OrYfIaWM=@protonmail.com>
References: <pYxS_SbGp4jLwzdYJKID7uwQCI5M1s6eTc1Ib1EohCNZ1HeNzc341ewCY15CatPmfxur4rEV3i6KhcKPlcU_CcxpS5_VSTLwbM_OrYfIaWM=@protonmail.com>

On Wednesday, 28 April 2021 05:05:47 CEST BrainGeek wrote:
> With ALFRED I've noticed a parameter you can pass into it labeled "-c" which is described to be a callback. I've tried things like "-c poweroff" just to make it obvious that the callback worked, but to no avail. How can I properly use this feature and how does it work?

Please have a look at the manpage [1].

    Specify command to execute on data change. It will be called
    with data-type list as arguments.

As you can see, the called command will have additional values added to the 
end. So you have to keep in mind that some commands don't like it when they 
receive extra parameters at the end. Let us simulate this with poweroff:

    $ poweroff 1
    Too many arguments.

So this will not work. You have to add some kind of wrapper which evaluates 
the numbers and then calls poweroff at the appropriate time. Let us define 
a small test script on host 1.

    host1$ cat > /tmp/alfred_cmd.sh << "EOF"
    #! /bin/sh
    
    echo "$(date): $@" >> /tmp/alfred_cmd_log
    
    for i in "$@"; do
       if [ "$i" = "123" ]; then
          poweroff
       fi
    done
    EOF
    
    host1$ chmod +x /tmp/alfred_cmd.sh

And now start the alfred instances on both hosts:

    host1$  alfred -m -i bat0 -c /tmp/alfred_cmd.sh
    host2$  alfred -m -i bat0


You can now inject data on host2

    host2$ echo foobar | alfred -s 65

and see the changed data-types on host1

   host1$ touch /tmp/alfred_cmd_log
   host1$ tail -f /tmp/alfred_cmd_log


If you write something to data-type 123 and you alfred instance is running 
with high enough privileges then it might shut down the system.

Kind regards,
	Sven


[1] https://downloads.open-mesh.org/batman/manpages/alfred.8.html
--nextPart1987721.Iqeva8pZxL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmCJAH0ACgkQXYcKB8Em
e0afhRAAx5EbwyB+6THQhLOgkPdx+0LV4uOJuRt98SW6HhFYPQxtLWTFF0xzcbfG
Yt4sl/R60lNNwoXp+4kV03bytENM12JP3nO9htkKsaB5h7Xai1qmXyVyk+GLv6VI
Kp1B9Auq+PA3zIADeBKxNiRHlEolY8FZb3xbYBIQVq/FjubT+nVuDbe029HVj8wP
Yhy9cafgPZRgfRg3tnTyGMH4SvxII2m/4i9hr218bB6nkj1H+npL9sG48vk7JbEh
CkxUR3qJvz0IZEZftATbE4Iz/UAdhn02tK/RxZJllRSUgcQusFigoihEjvPXMAx1
O1WAF1D3Xs1FgNn9iqd1WUeGLts4WVYX4K7cibGIkHfiyIsspY/VagUvnGOJipcL
AylqlEeguW1qzWTAfstoMuxkSWwaHUfH4oQoXBUxS/bJlp2Osj/9D54+SoI9kG2F
eCdJ2eN4SIui9+t4wGzKBHwlqx0LcTbI8PWF9KuSmMH3Mz0NPWptoP7gRdwHF8p7
Kpo4eCkztMKBzKYedwk8prHuCotr1NFzyhKaiBc5Ss7ORg5rIA+p/9QNWrSg/9bo
VEibeNbq3+dVyBRejSHHqXP9pJCmIiW+y2pf8IkXSAoznxOwmyUzb4bqVsifXJ37
jKLPbDMVF2Wg3h4jaEa8mTGgKTjIOO/sd6jR4Sijn3CI/zfhaa4=
=eHcD
-----END PGP SIGNATURE-----

--nextPart1987721.Iqeva8pZxL--


