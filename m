Return-Path: <germano.massullo@gmail.com>
From: Germano Massullo <germano.massullo@gmail.com>
Message-ID: <5612A7AE.2010508@gmail.com>
Date: Mon, 5 Oct 2015 18:39:10 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060805030202090901010405"
Subject: [B.A.T.M.A.N.] Questions arised while iplementing NetJSON
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

This is a multi-part message in MIME format.
--------------060805030202090901010405
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

I have some questions about JSONDoc created by command <<batadv-vis
--format=3Djsondoc>>
In jsondoc_commented file there are a few addresses that are not shown
in ip_addr file. I commented them using

    # non existing in file ip_addr

What are exactly the addresses in "clients"? What do they represent?
The procedure I followed to create the interfaces is available at [1]

Thank you for your time

[1]
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-September/013700.h=
tml


--------------060805030202090901010405
Content-Type: text/plain; charset=UTF-8;
 name="ip_addr"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="ip_addr"

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group=
 default=20
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host=20
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1532 qdisc fq_codel mast=
er bat0 state UP group default qlen 1000
    link/ether 08:00:27:83:e5:59 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.119/24 brd 192.168.1.255 scope global dynamic enp0s3
       valid_lft 42000sec preferred_lft 42000sec
    inet6 fdd7:4778:df22::d99/128 scope global dynamic=20
       valid_lft 85202sec preferred_lft 85202sec
    inet6 fdd7:4778:df22:0:a00:27ff:fe83:e559/64 scope global noprefixrou=
te dynamic=20
       valid_lft 7108sec preferred_lft 1708sec
    inet6 fe80::a00:27ff:fe83:e559/64 scope link=20
       valid_lft forever preferred_lft forever
3: bat0@NONE: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group =
default=20
    link/ether 2a:d7:37:c6:84:fa brd ff:ff:ff:ff:ff:ff



1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group=
 default=20
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host=20
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1532 qdisc fq_codel mast=
er bat0 state UP group default qlen 1000
    link/ether 08:00:27:8f:b1:c2 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.237/24 brd 192.168.1.255 scope global dynamic enp0s3
       valid_lft 41678sec preferred_lft 41678sec
    inet6 fdd7:4778:df22::a3d/128 scope global dynamic=20
       valid_lft 84879sec preferred_lft 84879sec
    inet6 fdd7:4778:df22:0:a00:27ff:fe8f:b1c2/64 scope global noprefixrou=
te dynamic=20
       valid_lft 6966sec preferred_lft 1566sec
    inet6 fe80::a00:27ff:fe8f:b1c2/64 scope link=20
       valid_lft forever preferred_lft forever
3: bat0@NONE: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group =
default=20
    link/ether c6:84:ae:77:3e:f1 brd ff:ff:ff:ff:ff:ff



1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group=
 default=20
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host=20
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1532 qdisc fq_codel mast=
er bat0 state UP group default qlen 1000
    link/ether 08:00:27:a9:8d:af brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.182/24 brd 192.168.1.255 scope global dynamic enp0s3
       valid_lft 39217sec preferred_lft 39217sec
    inet6 fdd7:4778:df22::1dd/128 scope global dynamic=20
       valid_lft 86019sec preferred_lft 86019sec
    inet6 fdd7:4778:df22:0:a00:27ff:fea9:8daf/64 scope global noprefixrou=
te dynamic=20
       valid_lft 6883sec preferred_lft 1483sec
    inet6 fe80::a00:27ff:fea9:8daf/64 scope link=20
       valid_lft forever preferred_lft forever
3: bat0@NONE: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue st=
ate UNKNOWN group default=20
    link/ether a2:7f:aa:75:15:f2 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::a07f:aaff:fe75:15f2/64 scope link=20
       valid_lft forever preferred_lft forever

--------------060805030202090901010405
Content-Type: text/plain; charset=UTF-8;
 name="jsondoc_commented"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="jsondoc_commented"

{
  "source_version" : "2015.1-2-g4384c2b-dirty",
  "algorithm" : 4,
  "vis" : [
    { "primary" : "08:00:27:8f:b1:c2",        # enp0s3 2nd virtual machin=
e
      "neighbors" : [
         { "router" : "08:00:27:8f:b1:c2",    # enp0s3 2nd virtual machin=
e
           "neighbor" : "08:00:27:a9:8d:af",  # enp0s3 3rd virtual machin=
e
           "metric" : "1.000" },
         { "router" : "08:00:27:8f:b1:c2",    # enp0s3 2nd virtual machin=
e
           "neighbor" : "08:00:27:83:e5:59",  # enp0s3 1st virtual machin=
e
           "metric" : "1.000" }
      ],
      "clients" : [
        "33:33:00:00:00:01",                  # non existing in file ip_a=
ddr
        "c6:84:ae:77:3e:f1"                   # bat0 2nd virtual machine
      ]
    },
    { "primary" : "08:00:27:83:e5:59",        # enp0s3 1st virtual machin=
e
      "neighbors" : [
         { "router" : "08:00:27:83:e5:59",    # enp0s3 1st virtual machin=
e
           "neighbor" : "08:00:27:a9:8d:af",  # enp0s3 3rd virtual machin=
e
           "metric" : "1.000" },
         { "router" : "08:00:27:83:e5:59",    # enp0s3 1st virtual machin=
e
           "neighbor" : "08:00:27:8f:b1:c2",  # enp0s3 2nd virtual machin=
e
           "metric" : "1.000" }
      ],
      "clients" : [
        "33:33:00:00:00:01",
        "2nd:d7:37:c6:84:fa"                   # bat0 1st virtual machine=

      ]
    },
    { "primary" : "08:00:27:a9:8d:af",        # enp0s3 3rd virtual machin=
e
      "neighbors" : [
         { "router" : "08:00:27:a9:8d:af",    # enp0s3 3rd virtual machin=
e
           "neighbor" : "08:00:27:8f:b1:c2",  # enp0s3 2nd virtual machin=
e
           "metric" : "1.000" },
         { "router" : "08:00:27:a9:8d:af",    # enp0s3 3rd virtual machin=
e
           "neighbor" : "08:00:27:83:e5:59",  # enp0s3 1st virtual machin=
e
           "metric" : "1.016" }
      ],
      "clients" : [
        "33:33:ff:75:15:f2",                  # non existing in file ip_a=
ddr
        "33:33:00:00:00:01",                  # non existing in file ip_a=
ddr
        "a2:7f:aa:75:15:f2",                  # bat0 3rd virtual machine
        "01:00:5e:00:00:01"                   # non existing in file ip_a=
ddr
      ]
    }
  ]
}

--------------060805030202090901010405--
