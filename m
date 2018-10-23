Return-Path: <combsca90@gmail.com>
MIME-Version: 1.0
From: Corey Combs <combsca90@gmail.com>
Date: Tue, 23 Oct 2018 10:22:29 -0400
Message-ID: <CAPzaX0gNh3g6wUmZJLuJnixYNVEkYjdiL3E=06acrSDw2amtvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [B.A.T.M.A.N.] Additional Assistance
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

All, thank you for the replies yesterday.  Would you be able to offer
some more insight into updating the 2 packages?  I have had some
successes, but not all the beagle bones have
recognized the new version of batman-adv when I run batctl -v.

The general method I've been using is the script here
https://gist.github.com/marvin/186a609d1e88f7426747 with version 2016.4.
The starting version on the Beagle Bones is batctl debian-2012.1.0-1 >
[batman-adv 2012.5.0] as mentioned previously.
After running this script and doing a
$ modprobe batman-adv
followed by
$ batctl -v
I get $ batctl 2016.4 [batman-adv 2012.5.0].

I have also attempted to uninstall batctl and batman-adv with
$ apt-get --purge remove batctl
 and
$ apt-get --purge remove batman-adv
and reinstall using the script, but that hasn't worked across all devices.

The laptop I have is running Debian 9.5 with batctl debian-2016.5-1
[batman-adv 2016.4] and the Beagles are running Debian 7.9.  I would
like to avoid reimaging the Beagles at this point in time.
Please pardon my lack of knowledge on the topic, as I'm still
relatively new to Linux and have been learning a great deal in the
past few months.
I greatly appreciate your help on the topic.

Regards,
Corey
