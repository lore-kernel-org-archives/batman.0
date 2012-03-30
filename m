Return-Path: <dan.carpenter@oracle.com>
Date: Fri, 30 Mar 2012 23:02:37 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20120330200236.GH3289@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] question about frag_can_reassemble()
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi Sven,

I had a question about the code in frag_can_reassemble().

net/batman-adv/unicast.h
    51  
    52          merged_size = (skb->len - sizeof(*unicast_packet)) * 2;
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    53          merged_size += sizeof(struct unicast_packet) + uneven_correction;
    54  
    55          return merged_size <= mtu;
    56  }

Can the skb->len be less than sizeof(*unicast_packet) (ie 20 bytes)?
If "len" is less than 10 then we would return false but if it's
over 10 then we would return true.  Roughly.

regards,
dan carpenter
