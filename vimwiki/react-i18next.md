Using Hocs
----------
In most cases we used [High Order Components](High Order Components) to share the t function among OHIF's components.

E.g.

```
import React from 'react';
import { withTranslation } from '@ohif/i18n';

function MyComponent({ t, i18n }) {
  return <p>{t('my translated text')}</p>;
}

export default withTranslation('MyNameSpace')(MyComponent);
```

Main Concepts While Translating
-------------------------------

* Namespaces

