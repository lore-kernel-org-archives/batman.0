Message-Id: <DFF8A357-1AF1-4F11-BE89-46DD131FA7FF@gmail.com>
From: Scott Raynel <scottraynel@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Thu, 4 Dec 2008 14:14:27 +1300
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv-kernelland: Fix memory corruption
	bug
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi there,

I've been spending some time tracking down a bug that's been causing  
memory corruption followed by random kernel panics. Thanks to the  
kernel's slab memory debugger I tracked it down to a kfree in send.c  
that was freeing a block of memory that had been written to past the  
end of its allocation.

Turned out to be a simple typo, which I've fixed in the following  
patch. When resizing the packet_buff struct in batman_if, the new  
length was being updated but the old length was being used for the  
kmalloc(), causing something later to think it had more memory  
allocated to write to, hence writing past the end of the allocation.

Signed-off-by: Scott Raynel <scottraynel@gmail.com>

Index: send.c
===================================================================
--- send.c	(revision 1105)
+++ send.c	(working copy)
@@ -159,7 +159,7 @@
  	if ((hna_local_changed) && (batman_if->if_num == 0)) {

  		new_len = sizeof(struct batman_packet) + (num_hna * ETH_ALEN);
-		new_buf = kmalloc(batman_if->pack_buff_len, GFP_ATOMIC);
+		new_buf = kmalloc(new_len, GFP_ATOMIC);

  		/* keep old buffer if kmalloc should fail */
  		if (new_buf) {


Cheers,

--
Scott Raynel
WAND Network Research Group
Department of Computer Science
University of Waikato
New Zealand



