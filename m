Return-Path: <germano.massullo@gmail.com>
References: <5609712B.6020308@gmail.com> <1942201.vOz91KHqBg@prime>
 <5609ACD4.3050701@gmail.com> <10386832.M3RZMRiWCT@prime>
From: Germano Massullo <germano.massullo@gmail.com>
Message-ID: <560A4F91.8010109@gmail.com>
Date: Tue, 29 Sep 2015 10:45:05 +0200
MIME-Version: 1.0
In-Reply-To: <10386832.M3RZMRiWCT@prime>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Suggestions to get extended jsondoc alfred output
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

Il 29/09/2015 01:24, Simon Wunderlich ha scritto:
> batadv-vis is also a daemon which must run in background to collect
> data from batman-adv and push it (periodically) into alfred. Maybe you
> are not running it but only used the client part to query? Cheers, Simo=
n=20
Yeah that was the problem, thank you very much!
I attach again the whole and fixed procedure I followed, hoping that it
can be useful to other people. At the end of the e-mail you can find
also the jsondoc output I got.

1) Install a Fedora VirtualBox virtual machine;
2) In the virtual machine VirtualBox settings, set the network interface
in bridge mode;
3) Clone two times the virtual machine, enabling the "re-initialise MAC
addresses" option;
4) Start them and then run the following commands on each of them:

    Maybe not required, but to avoid all possible problems, I also
disabled the firewall
    # systemctl disable firewalld; systemctl stop firewalld
  =20
    # dnf -y install batctl
    then download and install alfred from git source code (certain
guides show alfredadv-vis , I instead got batadv-vis)

    # ip link set dev enp0s3 mtu 1532
    # batctl if add enp0s3
    # ip link set bat0 up
    # alfred -i enp0s3 -m

    Then I opened a new console (tty2)
    # cat /etc/hostname | alfred -s 65
    # batadv-vis -s

    Then I opened a new console (tty3)
    # cat /etc/hostname | alfred -s 65
    # alfred -r 65  (note: this one will show the info sent from the
three nodes only if you entered the previous command on all the VMs)
    # batadv-vis --format=3Djsondoc


And here we go!







{
  "source_version" : "2015.1-2-g4384c2b",
  "algorithm" : 4,
  "vis" : [
    { "primary" : "08:00:27:8f:b1:c2",
      "neighbors" : [
         { "router" : "08:00:27:8f:b1:c2",
           "neighbor" : "08:00:27:a9:8d:af",
           "metric" : "1.000" },
         { "router" : "08:00:27:8f:b1:c2",
           "neighbor" : "08:00:27:83:e5:59",
           "metric" : "1.000" }
      ],
      "clients" : [
        "33:33:00:00:00:01",
        "33:33:ff:f4:13:fb",
        "d6:ba:c2:f4:13:fb",
        "01:00:5e:00:00:01"
      ]
    },
    { "primary" : "08:00:27:83:e5:59",
      "neighbors" : [
         { "router" : "08:00:27:83:e5:59",
           "neighbor" : "08:00:27:a9:8d:af",
           "metric" : "1.000" },
         { "router" : "08:00:27:83:e5:59",
           "neighbor" : "08:00:27:8f:b1:c2",
           "metric" : "1.016" }
      ],
      "clients" : [
        "1a:7c:e9:74:cc:47",
        "33:33:00:00:00:01",
        "33:33:ff:74:cc:47",
        "01:00:5e:00:00:01"
      ]
    },
    { "primary" : "08:00:27:a9:8d:af",
      "neighbors" : [
         { "router" : "08:00:27:a9:8d:af",
           "neighbor" : "08:00:27:8f:b1:c2",
           "metric" : "1.000" },
         { "router" : "08:00:27:a9:8d:af",
           "neighbor" : "08:00:27:83:e5:59",
           "metric" : "1.004" }
      ],
      "clients" : [
        "4e:ae:15:0e:ba:a2",
        "33:33:00:00:00:01",
        "01:00:5e:00:00:01",
        "33:33:ff:0e:ba:a2"
      ]
    }
  ]
}



