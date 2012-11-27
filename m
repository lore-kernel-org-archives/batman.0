Return-Path: <martin@hundeboll.net>
Message-ID: <50B478D4.3080308@hundeboll.net>
Date: Tue, 27 Nov 2012 09:24:52 +0100
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <cover.1353331252.git.martin@hundeboll.net>
 <b5f675c75c4dffa2454e635c19c73f7912eb7e74.1353331252.git.martin@hundeboll.net>
 <20121126002302.GH14547@ritirata.org>
In-Reply-To: <20121126002302.GH14547@ritirata.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [RFC 1/6] batman-adv: Add the initial code for
 network coding.
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <ordex@autistici.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 2012-11-26 01:23, Antonio Quartulli wrote:
>> +/**
>> >+ * struct batadv_priv - per mesh interface private data
>> >+ * @network_coding: enable/disable network coding
>> >+ * @batadv_priv_nc: network coding private data
>> >+ */
>> >  struct batadv_priv {
>> >  	atomic_t mesh_state;
>> >  	struct net_device_stats stats;
>> >@@ -308,6 +321,10 @@ struct batadv_priv {
>> >  #ifdef CONFIG_BATMAN_ADV_DAT
>> >  	struct batadv_priv_dat dat;
>> >  #endif
>> >+#ifdef CONFIG_BATMAN_ADV_NC
>> >+	atomic_t network_coding; /* boolean */
> just another style note: why don't you put this boolean switch together with the
> others?

Because of the sysfs-framework in batman-adv, that expects an atomic_t 
with the same name as the file to be in batadv_priv - just like with 
your DAT and Simon's BLAII :)


-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net
