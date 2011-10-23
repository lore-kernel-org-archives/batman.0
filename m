Return-Path: <bug-track@fisher-privat.net>
Message-ID: <4EA3E181.2020102@fisher-privat.net>
Date: Sun, 23 Oct 2011 11:42:25 +0200
From: Alexey Fisher <bug-track@fisher-privat.net>
MIME-Version: 1.0
References: <20111019082826.GA31323@pandem0nium>
	<20111023093802.GA6828@ritirata.org>
In-Reply-To: <20111023093802.GA6828@ritirata.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add sanity check when
 removing global tts
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

On 23.10.2011 11:38, Antonio Quartulli wrote:
> Hello,
> 
> On Wed, Oct 19, 2011 at 10:28:26AM +0200, Simon Wunderlich wrote:
>> After removing the batman-adv module, the hash may be already gone
>> when tt_global_del_orig() tries to clean the hash. This patch adds
>> a sanity check to avoid this.
>>
>> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
>> ---
> 
> I got a feedback on IRC from fishor_ who said that the patch solved the kernel
> panic problem on module unload and on soft_iface deactivating.
> 
> Thank you for the patch Simon!
> 

tested-by: Alexey Fisher <bug-track@fisher-privat.net>
