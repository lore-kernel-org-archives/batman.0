Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 7 Jun 2011 10:01:58 +0200
References: <1307400355-11624-1-git-send-email-daniele.furlan@gmail.com>
In-Reply-To: <1307400355-11624-1-git-send-email-daniele.furlan@gmail.com>
MIME-Version: 1.0
Message-Id: <201106071001.59176.lindner_marek@yahoo.de>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Mark as received also old
	rebroadcast
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

On Tuesday, June 07, 2011 12:45:55 AM Daniele Furlan wrote:
> This patch avoid local TQ drop in case of heavy load. In this case,
> rebroadcast can be delayed more than orig_interval causing the receiver
> to incorrectly drop old packets without marking them as received.

Do mind you explaining in more detail what led you to make this change and in 
which scenarios it improves the situation (please give a concrete example) ?

Thanks,
Marek
