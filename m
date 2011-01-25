Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 25 Jan 2011 23:00:31 +0100
References: <201101211826.08385.lindner_marek@yahoo.de>
	<1295631544-19884-1-git-send-email-sven@narfation.org>
In-Reply-To: <1295631544-19884-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201101252300.31798.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/2] batman-adv: Calculate correct size
	for merged packets
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Friday 21 January 2011 18:39:04 Sven Eckelmann wrote:
> The routing algorithm must be able to decide if a fragment can be merged
> with the missing part and still be passed to a forwarding interface. The
> fragments can only differ by one byte in case that the original payload
> had an uneven length. In that situation the sender has to inform all
> possible receivers that the tail is one byte longer using the flag
> UNI_FRAG_LARGETAIL.

Applied in revision 1916.

Thanks,
Marek
