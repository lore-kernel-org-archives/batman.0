Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu,  5 May 2016 13:09:38 +0200
Message-Id: <1462446587-5304-1-git-send-email-sven.eckelmann@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH/RFC v5 0/9] throughput meter
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

Hi,

I got no no other suggestion for the problems in my last RFC mails. So
I've just implemented the workaround with an extra socket. The idea is

 * userspace opens "batman-adv" "tpmeter" multicast netlink socket to
   listen for tpmeter events
 * tp_meter is started by userspace
   - kernel returns a u32 cookie for the session
 * userspace is listening for events on the multicast netlink socket
 * tp_meter either finishes or is cancelled
   - kernel sends tp_meter message containing the result over the
     multicast group for batman-adv tpmeter
 * userspace receives the events and matches against its own cookie
 * result is printed

This approach seems to work ok enough in my tests (only VMs [1]). But
the last patches are still marked as RFC because the use of multicast
groups introduces a backward compatibility problem. The 3.12 (and lower)
implementation for registering and starting multicast netlink messages
was completely different. backports.git has its own solution (which is
rather hard to read and I didn't start to figure out how to create a
small version for batman-adv) and someone could maybe port their
solution to the batman-adv compat code.

So if someone else wants to have a look at the compat code - please feel
free play around with it.

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/open-mesh/wiki/Emulation_Debug


