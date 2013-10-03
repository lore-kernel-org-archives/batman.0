Return-Path: <martin@hundeboll.net>
Message-ID: <524D0A04.4090702@hundeboll.net>
Date: Thu, 03 Oct 2013 08:09:08 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <20131001202648.GT11097@lunn.ch>
 <20131002130548.GA24077@pandem0nium> <20131002160106.GA1939@neomailbox.net>
In-Reply-To: <20131002160106.GA1939@neomailbox.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] Alfred batadv-vis json conformance
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 2013-10-02 18:01, Antonio Quartulli wrote:
> On Wed, Oct 02, 2013 at 03:05:48PM +0200, Simon Wunderlich wrote:
>>> > >I'm also wondering if label and gateway could have more meaningful
>>> > >names? TQ and host? Also, is TT the best?
>> >
>> >Hm, that is a good question. We also have the batman v with new metrics
>> >coming up, I'm not sure how to handle these (maybe Antonio has some
>> >idea?). It is not the TQ-value in the label after all, but some kind of
>> >ETX-converted value (255/TQ if i remember correctly).
> I think the ETX stuff comes from OLSR (but I don't know the details).
>
> I agree with Simon that we should find a generic name (e.g. metric ?) but I am
> not sure we can represent this value in a "algorithm-generic" fashion (and maybe
> we don't want to).

May I suggest that the cjson output includes an entry to tell the 
version of the batman-algorithm?

Users might want to do different map overlays (or whatever) depending on 
the available metric(s).

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net
