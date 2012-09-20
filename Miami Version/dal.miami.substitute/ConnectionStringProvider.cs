using System;

namespace Miami.Substitute.Dal
{
    public static class ConnectionStringProvider
    {
        #region Members

        private static string m_ConnectionString;

        #endregion

        #region Public Properties

        public static string ConnectionString
        {
            get { return m_ConnectionString; }
            set { m_ConnectionString = value; }
        }

        #endregion
    }
}
