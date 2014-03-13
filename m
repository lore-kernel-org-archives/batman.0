Return-Path: <itamar@itamar.org>
MIME-Version: 1.0
Date: Thu, 13 Mar 2014 11:24:00 +0200
Message-ID: <CAMcTwKrV4OVZP6v3hD2_4t8DWsmymGYgu9xMZa6aexrWQuORtQ@mail.gmail.com>
From: Itamar Landsman <itamar@itamar.org>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] IP connection lost when a node is rebooted
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

HI,
I am running a project using Raspberry pi machines that create a
batman-adv mesh.
Each of the rpis has three wifi devices. each of the wifi devices
hosts a separate ad-hoc network. This way I can get to work on three
separate channels and let batman worry about paths.

My problem is that whenever I reboot a device, it comes back to life
but IP connection is never regained until; I reboot all other devices.

I have tried to move the IP address from the bt0 interface to a bridge
interface that hosts br0 with no success.

Any ideas?

I am using the "Out of the box" batman-adv modules and batctl that
come with the most recent raspbian repo.


Thanks in advance,
Itamar
