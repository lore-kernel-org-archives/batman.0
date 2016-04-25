Return-Path: <dvlasenk@redhat.com>
Message-ID: <571E1F70.3040001@redhat.com>
Date: Mon, 25 Apr 2016 15:45:20 +0200
From: Denys Vlasenko <dvlasenk@redhat.com>
MIME-Version: 1.0
References: <1461590722-2095-1-git-send-email-dvlasenk@redhat.com>
 <20160425133950.GH3381@prodigo>
In-Reply-To: <20160425133950.GH3381@prodigo>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Deinline
 batadv_orig_hash_find, save 9024 bytes
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: linux-kernel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

On 04/25/2016 03:39 PM, Antonio Quartulli wrote:
> On Mon, Apr 25, 2016 at 03:25:22PM +0200, Denys Vlasenko wrote:
>> This function compiles to 473 bytes of machine code.
>> 21 callsites.
>>
>>     text     data      bss       dec     hex filename
>> 95903266 20860288 35991552 152755106 91adba2 vmlinux_before
>> 95894242 20860288 35991552 152746082 91ab862 vmlinux
> 
> Hi Danys,
> 
> thanks for your patch. This function is used in a several performance critical
> code paths (i.e. packet forwarding).
> 
> Are we sure we are not losing in performance here?

Is this a common case?

	if (!hash)
		return NULL;

If yes, then we can inline this part only.

