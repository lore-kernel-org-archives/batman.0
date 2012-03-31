Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 31 Mar 2012 11:52:42 +0300
References: <20120330200236.GH3289@mwanda>
In-Reply-To: <20120330200236.GH3289@mwanda>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201203311152.42590.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] question about frag_can_reassemble()
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>


Dan,

> I had a question about the code in frag_can_reassemble().
> 
> net/batman-adv/unicast.h
>     51
>     52          merged_size = (skb->len - sizeof(*unicast_packet)) * 2;
>                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     53          merged_size += sizeof(struct unicast_packet) +
> uneven_correction; 54
>     55          return merged_size <= mtu;
>     56  }
> 
> Can the skb->len be less than sizeof(*unicast_packet) (ie 20 bytes)?
> If "len" is less than 10 then we would return false but if it's
> over 10 then we would return true.  Roughly.

the calling function checks for an existing unicast header. The call tree 
looks like this: 
recv_ucast_frag_packet() -> route_unicast_packet() -> frag_can_reassemble()
The first function does a unicast length check by calling 
check_unicast_packet(). As a result we ensure that we at least have the length 
of the unicast header in our packet unless we overlooked something ?

Regards,
Marek
