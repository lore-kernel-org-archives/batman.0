Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 23 Jun 2010 17:58:39 +0200
References: <201006231620.11058.lindner_marek@yahoo.de>
	<1277302839-20197-1-git-send-email-lindner_marek@yahoo.de>
	<20100623150913.GJ15420@lunn.ch>
In-Reply-To: <20100623150913.GJ15420@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201006231758.40146.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: add routing debug log
	accessible via debugfs
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

On Wednesday 23 June 2010 17:09:13 Andrew Lunn wrote:
> There will be a ring buffer per mesh. When debugging problems between
> meshes it is likely both logs will be combined performing a merge
> based on the timestamp. However at this point you have lost
> information about which line belongs to which mesh. Could we maybe
> include the soft interface name in the output?

Actually, this information is (indirectly) present, since each log file resides 
inside debugfs/batman_adv/$mesh_if/log. It would be a little bit redundant to 
add this on every line, wouldn't you agree ? If someone merges 2 mesh files it 
still can be added ?


> Also, do you really want to do jiffies / HZ? You are throwing away
> useful information. Either keep it as jiffies, or scale the remainder
> to ms and print it as well?

You are right - we could leave it as jiffies. Might be the best solution.

Regards,
Marek
