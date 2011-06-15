Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 15 Jun 2011 21:04:15 +0200
References: <1308123697-7893-1-git-send-email-sven@narfation.org>
	<1308123697-7893-2-git-send-email-sven@narfation.org>
In-Reply-To: <1308123697-7893-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201106152104.16054.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: count_real_packets() in
	batman-adv assumes char is signed
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

On Wednesday, June 15, 2011 09:41:36 AM Sven Eckelmann wrote:
> From: David Howells <dhowells@redhat.com>
> 
> count_real_packets() in batman-adv assumes char is signed, and returns -1
> through it:
> 
> net/batman-adv/routing.c: In function 'receive_bat_packet':
> net/batman-adv/routing.c:739: warning: comparison is always false due to
> limited range of data type
> 
> Use int instead.

Applied in revision fdc8438.

Thanks,
Marek
