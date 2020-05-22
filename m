Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Batman-adv packet retranslation
Date: Fri, 22 May 2020 08:25:26 +0200
Message-ID: <4485194.d5W8GeZ6RB@sven-edge>
In-Reply-To: <CAOVt3fEEaLx8-58NjVXU0L6XToB5FPvGjFaEoZBeRCL+Eh-QWw@mail.gmail.com>
References: <CAOVt3fEEaLx8-58NjVXU0L6XToB5FPvGjFaEoZBeRCL+Eh-QWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1661235.Aae2KU2pNo"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Alexey Ermakov <axel101@gmail.com>

 
--nextPart1661235.Aae2KU2pNo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 21 May 2020 19:13:18 CEST Alexey Ermakov wrote:
[...]
> I have 3 stations, st1, st2 and st3 with one active network interface.
> This interface is configured so that st1 and st3 can see only st2.
[...]
> This works fine if I selecting B.A.T.M.A.N. IV algorithm, but doesn't
> work in B.A.T.M.A.N.V.

That's not a lot to work with. I am rather sure that the B.A.T.M.A.N. V 
developers will not be able to figure out what is going on with this 
information.

I have just tried it out in my documented setup [1,2] and following 
test-init.sh::

    #! /bin/sh
    
    set -e
    export PATH="/host/batctl/:$PATH"
    
    insmod /host/batman-adv/net/batman-adv/batman-adv.ko
    batctl routing_algo BATMAN_V
    /host/batctl/batctl if add enp0s1
    ip link set up dev enp0s1
    ip link set up dev bat0
    
    MAC_PART="$(ip link show enp0s1 | awk "/ether/ {print \$2}"| sed -e "s/.*://" -e "s/[\\n\\ ].*//"|awk "{print (\"0x\"\$1)*1 }")"
    IP_PART="$(echo $MAC_PART|awk "{ print \$1 }")"
    ip addr replace 192.168.55.${IP_PART}/24 dev bat0

The used kernel version is next-20200521 and batman-adv 2020.1.

These are the neighbor and originator tables of the devices + ping test
results:

* node1

  - neighbor::

      [B.A.T.M.A.N. adv 2020.1, MainIF/MAC: enp0s1/02:ba:de:af:fe:01 (bat0/12:99:c8:a5:1e:27 BATMAN_V)]
      IF             Neighbor              last-seen
      02:ba:de:af:fe:02    0.528s (        1.0) [    enp0s1]

  - originator::

      [B.A.T.M.A.N. adv 2020.1, MainIF/MAC: enp0s1/02:ba:de:af:fe:01 (bat0/12:99:c8:a5:1e:27 BATMAN_V)]
         Originator        last-seen ( throughput)  Nexthop           [outgoingIF]
       * 02:ba:de:af:fe:03    0.704s (        0.8)  02:ba:de:af:fe:02 [    enp0s1]
       * 02:ba:de:af:fe:02    0.704s (        1.0)  02:ba:de:af:fe:02 [    enp0s1]

  - bat0 ping::

      $ for i in $(seq 1 3); do ping -q -c 3 192.168.55.$i; done
      PING 192.168.55.1 (192.168.55.1) 56(84) bytes of data.
      
      --- 192.168.55.1 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 28ms
      rtt min/avg/max/mdev = 0.482/0.539/0.613/0.060 ms
      PING 192.168.55.2 (192.168.55.2) 56(84) bytes of data.
      
      --- 192.168.55.2 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 8ms
      rtt min/avg/max/mdev = 1.797/1.940/2.060/0.114 ms
      PING 192.168.55.3 (192.168.55.3) 56(84) bytes of data.
      
      --- 192.168.55.3 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 10ms
      rtt min/avg/max/mdev = 2.105/3.021/3.962/0.760 ms

  - enp1s0 ping::

      $ for i in $(seq 1 3); do ping -q -c 3 192.168.251.5$i; done
      PING 192.168.251.51 (192.168.251.51) 56(84) bytes of data.
      
      --- 192.168.251.51 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 36ms
      rtt min/avg/max/mdev = 0.170/0.396/0.510/0.160 ms
      PING 192.168.251.52 (192.168.251.52) 56(84) bytes of data.
      
      --- 192.168.251.52 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 8ms
      rtt min/avg/max/mdev = 1.572/2.353/3.192/0.664 ms
      PING 192.168.251.53 (192.168.251.53) 56(84) bytes of data.
      
      --- 192.168.251.53 ping statistics ---
      3 packets transmitted, 0 received, +3 errors, 100% packet loss, time 41ms

* node2

  - neighbor::

      [B.A.T.M.A.N. adv 2020.1, MainIF/MAC: enp0s1/02:ba:de:af:fe:02 (bat0/32:a0:63:19:b4:44 BATMAN_V)]
      IF             Neighbor              last-seen
      02:ba:de:af:fe:03    0.208s (        1.0) [    enp0s1]
      02:ba:de:af:fe:01    0.344s (        1.0) [    enp0s1]

  - originator::

      [B.A.T.M.A.N. adv 2020.1, MainIF/MAC: enp0s1/02:ba:de:af:fe:02 (bat0/32:a0:63:19:b4:44 BATMAN_V)]
         Originator        last-seen ( throughput)  Nexthop           [outgoingIF]
       * 02:ba:de:af:fe:03    0.188s (        1.0)  02:ba:de:af:fe:03 [    enp0s1]
       * 02:ba:de:af:fe:01    0.016s (        1.0)  02:ba:de:af:fe:01 [    enp0s1]

  - bat0 ping::

      $ for i in $(seq 1 3); do ping -q -c 3 192.168.55.$i; done
      PING 192.168.55.1 (192.168.55.1) 56(84) bytes of data.
      
      --- 192.168.55.1 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 7ms
      rtt min/avg/max/mdev = 1.961/2.510/3.484/0.691 ms
      PING 192.168.55.2 (192.168.55.2) 56(84) bytes of data.
      
      --- 192.168.55.2 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 38ms
      rtt min/avg/max/mdev = 0.287/0.481/0.606/0.140 ms
      PING 192.168.55.3 (192.168.55.3) 56(84) bytes of data.
      
      --- 192.168.55.3 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 9ms
      rtt min/avg/max/mdev = 1.215/1.737/2.038/0.370 ms

  - enp1s0 ping::

      $ for i in $(seq 1 3); do ping -q -c 3 192.168.251.5$i; done
      PING 192.168.251.51 (192.168.251.51) 56(84) bytes of data.
      
      --- 192.168.251.51 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 10ms
      rtt min/avg/max/mdev = 1.114/1.698/2.107/0.425 ms
      PING 192.168.251.52 (192.168.251.52) 56(84) bytes of data.
      
      --- 192.168.251.52 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 14ms
      rtt min/avg/max/mdev = 0.360/0.747/1.270/0.384 ms
      PING 192.168.251.53 (192.168.251.53) 56(84) bytes of data.
      
      --- 192.168.251.53 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 7ms
      rtt min/avg/max/mdev = 1.909/2.427/2.692/0.371 ms

* node3

  - neighbor::

      [B.A.T.M.A.N. adv 2020.1, MainIF/MAC: enp0s1/02:ba:de:af:fe:03 (bat0/7a:f4:94:ef:b6:6d BATMAN_V)]
      IF             Neighbor              last-seen
      02:ba:de:af:fe:02    0.072s (        1.0) [    enp0s1]

  - originator::

      [B.A.T.M.A.N. adv 2020.1, MainIF/MAC: enp0s1/02:ba:de:af:fe:03 (bat0/7a:f4:94:ef:b6:6d BATMAN_V)]
         Originator        last-seen ( throughput)  Nexthop           [outgoingIF]
       * 02:ba:de:af:fe:01    0.764s (        0.8)  02:ba:de:af:fe:02 [    enp0s1]
       * 02:ba:de:af:fe:02    0.148s (        1.0)  02:ba:de:af:fe:02 [    enp0s1]

  - bat0 ping::

      $ for i in $(seq 1 3); do ping -q -c 3 192.168.55.$i; done
      PING 192.168.55.1 (192.168.55.1) 56(84) bytes of data.
      
      --- 192.168.55.1 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 10ms
      rtt min/avg/max/mdev = 1.736/2.948/3.925/0.910 ms
      PING 192.168.55.2 (192.168.55.2) 56(84) bytes of data.
      
      --- 192.168.55.2 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 11ms
      rtt min/avg/max/mdev = 2.081/2.175/2.361/0.136 ms
      PING 192.168.55.3 (192.168.55.3) 56(84) bytes of data.
      
      --- 192.168.55.3 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 27ms
      rtt min/avg/max/mdev = 0.278/0.489/0.649/0.156 ms

  - enp1s0 ping::

      $ for i in $(seq 1 3); do ping -q -c 3 192.168.251.5$i; done
      PING 192.168.251.51 (192.168.251.51) 56(84) bytes of data.
      
      --- 192.168.251.51 ping statistics ---
      3 packets transmitted, 0 received, +3 errors, 100% packet loss, time 43ms
      pipe 3
      PING 192.168.251.52 (192.168.251.52) 56(84) bytes of data.
      
      --- 192.168.251.52 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 10ms
      rtt min/avg/max/mdev = 1.025/1.569/1.997/0.405 ms
      PING 192.168.251.53 (192.168.251.53) 56(84) bytes of data.
      
      --- 192.168.251.53 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 61ms
      rtt min/avg/max/mdev = 0.214/0.376/0.480/0.117 ms


And it seems I can communicate with all nodes perfectly fine. And the 
communication between node1 and node3 seems to be blocked as expected on 
enp1s0 (the slave device of bat0).

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/open-mesh/wiki/Kernel_hacking_Debian_image
[2] https://www.open-mesh.org/projects/open-mesh/wiki/Advanced_Bridge_virtual_network#Allow-communication-between-specific-nodes

--nextPart1661235.Aae2KU2pNo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl7HcFYACgkQXYcKB8Em
e0ZsjQ//eioUWHwQiTV9QQNZPxU7TdCwdH3x6/ELCS0Lj/oLvwkbS107GTFEbum1
5SjtX/bcrmggWnQ8tpr/v4TRnp5wQ81srhfk8QG3YTA3vlvMqTQtBPYjMxl1KoFH
u0jnpuWiDfULFtFtMNRdacOPp03p6dNZuO/y71AUnTtZtinyKTay3NDWverb0T8b
YD5l0lvL4sM1TYEjP/M2GSVy58g1J1DoTlrZSIQ1dvbCyHNY9Yu362vUkMj0dnU3
hXZuJerbU2nh/syy+RzUnmIz9gKQCOwWeVnIUQWpOvti/veu0A6fjRCtXAvkVKX4
xuxm0AIfZlWnvCfE3cEjeHP8Fv/p3gIojw3X6ooA0YQeS+cBnjePloBnZwX4w4K2
IKhaK07oM4qSj+vx45xzEe1BlpsJ1EHor7y2McK9cNbHOKO+Wt0XbXfDK8KhmUfi
nypfy1CYL4SUeyky8m3qyfhuJS/OS+Q4SKXCviGDVzzaVUu5ldCZ4bhnGRFknt7Z
ddV3mEa6FB8mg/GnQWKsagBcMGihPNFdtYMDqLEW+UkWXmHoF4xkDp06rIMvf0km
Db4lcpj4/+sKdTvLzFYV27Ylgk28x/wU7oKMvx9EnYHdzTBSS5lNAAVuQHtf0zbu
tG3z4ElJ7+QKNiG4WujS9HCNTLGDE7/5u+Onap6MsbLhgaglXLs=
=EIki
-----END PGP SIGNATURE-----

--nextPart1661235.Aae2KU2pNo--


