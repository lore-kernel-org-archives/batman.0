Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 28 May 2011 17:08:43 +0200
References: <201105281443.35742.sven@narfation.org>
	<1306587066-7102-1-git-send-email-sven@narfation.org>
In-Reply-To: <1306587066-7102-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105281708.43724.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3-sven] batman-adv: Unify the first 3
	bytes in each packet
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

On Saturday 28 May 2011 14:51:06 Sven Eckelmann wrote:
> From: Antonio Quartulli <ordex@autistici.org>
> 
> The amount of duplicated code in the receive and routing code can be
> reduced when all headers provide the packet type, version and ttl in the
> same first bytes.

Applied in revision c7fb529.

Thanks,
Marek
