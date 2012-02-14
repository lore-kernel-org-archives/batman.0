Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 14 Feb 2012 14:07:57 +0800
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
	<201202112159.58282.lindner_marek@yahoo.de>
	<20120213203343.GA19783@ritirata.org>
In-Reply-To: <20120213203343.GA19783@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202141407.57905.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 3/9] batman-adv: Distributed ARP Table
	- create DHT helper functions
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

On Tuesday, February 14, 2012 04:33:52 Antonio Quartulli wrote:
> > Moreover, the name dht_hash is a bit confusing. At first I thought it is
> > a pointer to a hash (read: orig_hash/tt_local_hash/tt_global_hash/etc).
> 
> ok, I'll rename it to dht_id (or dht_addr ?)

It is difficult for me to suggest a better name because I don't understand 
what this variable is used for. 

Regards,
Marek
