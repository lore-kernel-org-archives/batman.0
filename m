Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Dynamic DHCP server assignment and spin-up on batman-adv mesh network
From: tanner.perkins@cnftech.com
Date: Tue, 31 Aug 2021 17:28:41 -0000
Message-ID: <20210831172841.1195.74688@diktynna.open-mesh.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

If this is not the best place to ask questions regarding mesh networks utilizing the batman-adv kernel module, I apologies and please point me to where I need to be.

I'm looking to set up distributed mesh network using the batman-adv Linux kernel module. However, I don't want to have to statically assign IP addresses to all my nodes therefore my first thought was to use DHCP. The problem arises in my scenario that any node could come and go in the mesh network as they move in and out range of the network. Therefore manually allocating a single or even a few DHCP servers isn't realistic as that DHCP server may drop out of the network at anytime. Is there a dynamic way to reassign the DHCP server based on the nodes still within the network when the previous DHCP server drops from the network?

Thanks,
-tdev
