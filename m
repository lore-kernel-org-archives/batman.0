Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 8 Sep 2011 19:31:40 +0200
References: <1315500051-1122-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1315500051-1122-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201109081931.40309.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2011-09-08
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
Cc: netdev@vger.kernel.org, davem@davemloft.net

On Thursday, September 08, 2011 18:40:44 Marek Lindner wrote:
> here comes the next batch batch I'd like to get the pulled into 
> net-next-2.6/3.2. These patches mainly focus restructering the 
> routing code in order to allow the kernel module the handling
> of the current routing algorithm and the upcoming one. 
> 
> To ensure a smooth transition and efficient testing later, we 
> decided to offer a choice of routing algorithm but have not     
> come to a final decision on how to design this choice yet. It
> either will be a compile time option, a module parameter or a
> runtime switch. Any suggestions / best practice tips ?
> 
> Note: The new algorithm has been designed with backward 
> compatibility in mind (using TLVs). We are trying to address
> the incompatibility issue you and others have pointed out.

Forgot to mention: We are well aware of the difficulties after 
the kernel.org intrusion. If you can't pull our patches right
now, feel free to do it whenever kernel.org is back online.

Regards,
Marek
